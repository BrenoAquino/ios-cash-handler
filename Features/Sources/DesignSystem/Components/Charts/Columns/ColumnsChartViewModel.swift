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
        let maxValue: Double = 10
        let values: [Double] = [2, 4, 5, 7, 10]
        
        // MARK: Publishers
        @Published private(set) var offsets: [Double] = []
        
        // MARK: Inits
        init() {
            setupOffsets()
        }
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
