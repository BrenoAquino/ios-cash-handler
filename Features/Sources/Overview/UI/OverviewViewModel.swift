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
        @Published private(set) var historicOverview: [OverviewMonthUI] = []
        @Published private(set) var historicConfig: ColumnsChartConfig = .init(max: .zero, min: .zero, verticalTitles: [])
        
        // MARK: Redirects
        
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
}

// MARK: - Flow
extension OverviewView.ViewModel {
    func fetchStats() {
        let monthOverview = statsUseCase.monthOverview(month: currentMonth.month, year: currentMonth.year)
        let categories = statsUseCase.categories(month: currentMonth.month, year: currentMonth.year)
        let historic = statsUseCase.historic(numberOfMonths: 6)
        
        monthOverview
            .zip(categories, historic)
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
                self?.overviewMonth = .init(monthOverview: stats.0)
                self?.categoriesOverview = stats.1.map { .init(categoryOverview: $0) }
                self?.historicOverview = stats.2.map { .init(monthOverview: $0) }
                
                let max: Double = stats.2.max(by: { $0.expense < $1.expense })?.expense ?? .zero
                let interval: Int = (max / Double(DSOverview.numberOfVerticalTitles - .one)).ceilMaxDecimal
                
                let numberOfTitles: [Int] = Array(.zero ... DSOverview.numberOfVerticalTitles)
                let verticalTitles: [String] = numberOfTitles.map { NumberFormatter.inThousands(number: $0 * interval) }.reversed()
                
                let values: [ColumnsValue] = stats.2.map { monthOverview in
                    ColumnsValue(value: monthOverview.expense, abbreviation: "Mar", fullSubtitle: "Mar 2022")
                }
                
                self?.historicConfig = .init(
                    max: Double(DSOverview.numberOfVerticalTitles * interval),
                    min: .zero,
                    verticalTitles: verticalTitles,
                    values: values
                )
            }
            .store(in: &cancellables)
    }
}
