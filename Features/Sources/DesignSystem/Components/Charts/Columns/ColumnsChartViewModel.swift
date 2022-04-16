//
//  ColumnsViewModel.swift
//  
//
//  Created by Breno Aquino on 10/04/22.
//

import SwiftUI

extension ColumnsChart {
    final class ViewModel: ObservableObject {
        
        let minValue: Double = .zero
        let maxValue: Double = 12.5
        let values: [Double] = [2, 2.5, 5, 10]
        
        // MARK: Publishers
        @Published private(set) var selectedIndex: Int = 3
        @Published private(set) var offsets: [Double] = []
        @Published private(set) var verticalTitles: [String] = ["12,5K", "10K", "7.5K", "5K", "2.5K", "0"]
        @Published private(set) var horizontalTitles: [String] = ["Jan", "Fev", "Mar", "Abr"]
        
        // MARK: Inits
        init() {
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
        let interval = maxValue - minValue
        
        for value in values {
            offsets.append(value / interval)
        }
    }
}
