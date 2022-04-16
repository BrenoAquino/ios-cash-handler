//
//  ColumnsViewModel.swift
//  
//
//  Created by Breno Aquino on 10/04/22.
//

import SwiftUI

extension ColumnsChart {
    final class ViewModel: ObservableObject {
        
        var values: [Double]
        
        // MARK: Publishers
        @Published private(set) var config: ColumnsChartConfig
        @Published private(set) var selectedIndex: Int = 3
        @Published private(set) var offsets: [Double] = []
        
        // MARK: Inits
        init(config: ColumnsChartConfig, values: [Double]) {
            self.config = config
            self.values = values
            
            setupOffsets()
        }
    }
}

// MARK: Actions
extension ColumnsChart.ViewModel {
    func select(index: Int) {
        selectedIndex = index
    }
}

// MARK: Offsets
extension ColumnsChart.ViewModel {
    func setupOffsets() {
        offsets = []
        let interval = config.max - config.min
        
        for value in values {
            offsets.append(value / interval)
        }
    }
}
