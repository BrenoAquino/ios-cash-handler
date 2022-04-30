//
//  File.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import Foundation
import Combine
import DesignSystem
import Domain

public extension OverviewView {
    
    final class ViewModel: ObservableObject {
        
        // MARK: - Constants
        private static let numberOfMonths: Int = 6
        
        // MARK: - Proprieties
        private let statsUseCase: Domain.StatsUseCase
        private var cancellables: Set<AnyCancellable> = .init()
        
        private let currentMonth: (month: Int, year: Int)
        let month: String
        let year: String
        
        // MARK: Publisher
        @Published var banner: BannerControl = .init(show: false, data: .empty)
        @Published private(set) var state: ViewState = .loading
        @Published private(set) var overviewMonth: OverviewMonthUI = .placeholder
        @Published private(set) var categoriesOverview: [CategoryOverviewUI] = []
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
extension OverviewView.ViewModel {
    private func setupErrorBanner(error: CharlesError) {
        banner.data = .init(title: Localizable.Common.failureTitleBanner,
                            subtitle: error.localizedDescription,
                            type: .failure)
        banner.show = true
    }
    
    private func generateColumnsConfig(months: [Domain.MonthStats]) -> ColumnsChartConfig {
        let max: Double = months.max(by: { $0.expense < $1.expense })?.expense ?? .zero
        let interval: Int = (max / Double(DSOverview.numberOfVerticalTitles - .one)).ceilMaxDecimal
        
        let numberOfTitles: [Int] = Array(.zero ... DSOverview.numberOfVerticalTitles)
        let verticalTitles: [String] = numberOfTitles.map { NumberFormatter.inThousands(number: $0 * interval) }.reversed()
        
        let values: [ColumnsValue] = months.map { monthOverview in
            let date = Date.components(day: .one, month: monthOverview.month, year: monthOverview.year) ?? .distantPast
            let valueFormatted = NumberFormatter.inThousands(number: monthOverview.expense)
            let value = Localizable.Common.currency(valueFormatted)
            return ColumnsValue(
                value: monthOverview.expense,
                valueFormatted: value,
                abbreviation: date.monthAbbreviation,
                fullSubtitle: date.monthWithYear.capitalized
            )
        }
        
        return ColumnsChartConfig(
            max: Double(DSOverview.numberOfVerticalTitles * interval),
            min: .zero,
            verticalTitles: verticalTitles,
            values: values
        )
    }
}

// MARK: - Flow
extension OverviewView.ViewModel {
    func fetchStats() {
        let stats = statsUseCase.stats()
        let historic = statsUseCase.historic(numberOfMonths: Self.numberOfMonths)
        
        stats
            .zip(historic)
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
