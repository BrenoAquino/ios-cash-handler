//
//  StatsViewModel.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import Combine
import DesignSystem
import Domain

public extension StatsView {
    
    final class ViewModel: ObservableObject {
        
        // MARK: - Constants
        private static let numberOfMonths: Int = 6
        
        // MARK: - Proprieties
        private let statsUseCase: Domain.StatsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        private let currentMonth: (month: Int, year: Int)
        let month: String
        let year: String
        
        // MARK: Redirects
        public var selectAddOperation: (() -> Void)?
        
        // MARK: Publisher
        @Published var banner: BannerControl = .init(show: false, data: .empty)
        @Published private(set) var state: ViewState = .loading
        @Published private(set) var overviewMonth: MonthStatsUI = .placeholder
        @Published private(set) var categoriesOverview: [CategoryStatsUI] = []
        @Published private(set) var historicConfig: ColumnsChartConfig = .init(max: .zero, min: .zero, verticalTitles: [])
        
        // MARK: - Inits
        public init(statsUseCase: Domain.StatsUseCase) {
            self.statsUseCase = statsUseCase
            
            let components = Calendar.current.dateComponents([.month, .year], from: .now)
            self.currentMonth = (components.month ?? .zero, components.year ?? .zero)
            
            self.month = Date.monthName(month: components.month ?? .zero).capitalized
            self.year = DateFormatter(pattern: "yyyy").string(from: .now)
        }
    }
}

// MARK: - Setups
extension StatsView.ViewModel {
    private func setupErrorBanner(error: CharlesError) {
        banner.data = .init(title: Localizable.Common.failureTitleBanner,
                            subtitle: error.localizedDescription,
                            type: .failure)
        banner.show = true
    }
    
    private func generateColumnsConfig(months: [Domain.MonthStats]) -> ColumnsChartConfig {
        let max: Double = months.max(by: { $0.expense < $1.expense })?.expense ?? .zero
        let interval: Int = (max / Double(DSStats.numberOfVerticalTitles - .one)).ceilMaxDecimal
        
        let numberOfTitles: [Int] = Array(.zero ... DSStats.numberOfVerticalTitles)
        let verticalTitles: [String] = numberOfTitles.map { NumberFormatter.inThousands(number: $0 * interval) }.reversed()
        
        let values: [ColumnsValue] = months.map { monthStats in
            let valueFormatted = NumberFormatter.inThousands(number: monthStats.expense)
            let value = Localizable.Common.currency(valueFormatted)
            return ColumnsValue(
                value: monthStats.expense,
                valueFormatted: value,
                abbreviation: monthStats.month.monthAbbreviation,
                fullSubtitle: monthStats.month.monthWithYear.capitalized
            )
        }
        
        return ColumnsChartConfig(
            max: Double(DSStats.numberOfVerticalTitles * interval),
            min: .zero,
            verticalTitles: verticalTitles,
            values: values
        )
    }
}

// MARK: - Flow
extension StatsView.ViewModel {
    func fetchStats() {
        let stats = statsUseCase.stats()
        let historic = statsUseCase.historic(numberOfMonths: Self.numberOfMonths)
        
        Publishers.Zip(stats, historic)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .content
                case .failure(let error):
                    self?.setupErrorBanner(error: error)
                    self?.state = .failure
                }
            } receiveValue: { [weak self] stats in
                guard let self = self else { return }
                self.overviewMonth = .init(stats: stats.0)
                self.categoriesOverview = stats.0.categories.map { .init(categoryStats: $0) }
                self.historicConfig = self.generateColumnsConfig(months: stats.1)
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions
extension StatsView.ViewModel {
    func selectAdd() {
        selectAddOperation?()
    }
}
