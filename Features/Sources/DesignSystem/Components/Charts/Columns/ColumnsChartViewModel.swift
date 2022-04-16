//
//  ColumnsViewModel.swift
//  
//
//  Created by Breno Aquino on 10/04/22.
//

import SwiftUI

extension ColumnsChart {
    final class ViewModel: ObservableObject {
        
        var config: ColumnsChartConfig {
            didSet { update() }
        }
        
        // MARK: Publishers
        @Published private(set) var offsets: [Double] = []
        @Published private(set) var verticalTitles: [String] = []
        @Published private(set) var horizontalTitles: [String] = []
        @Published private(set) var selectedColumn: (index: Int, value: ColumnsChartConfig.ColumnsValue)? = nil
        
        // MARK: Inits
        init(config: ColumnsChartConfig) {
            self.config = config
            update()
        }
    }
}

// MARK: Actions
extension ColumnsChart.ViewModel {
    func select(index: Int) {
        guard index >= .zero && index <= config.values.count else { return }
        selectedColumn = (index, config.values[index])
    }
}

// MARK: Updates
extension ColumnsChart.ViewModel {
    private func update() {
        updateColumns()
        updateVerticalTitles()
    }
    
    private func updateColumns() {
        let interval = config.max - config.min
        offsets = config.values.map { $0.value / interval }
        horizontalTitles = config.values.map { $0.abbreviation }
        select(index: config.values.count - .one)
    }
    
    private func updateVerticalTitles() {
        verticalTitles = config.verticalTitles
    }
}
