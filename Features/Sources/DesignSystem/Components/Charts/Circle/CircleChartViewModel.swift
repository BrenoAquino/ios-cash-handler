//
//  CircleCoreChartViewModel.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

extension CircleChart {
    final class ViewModel: ObservableObject {
        typealias ValuesConfig = (arcs: [ArcConfig], subtitles: [SubtitleConfig])
        
        let config: CircleChartConfig
        
        // MARK: Publishers
        @Published private(set) var valuesConfig: ValuesConfig = ([], [])
        @Published private(set) var hasSubtitle: Bool = true
        
        // MARK: Inits
        init(config: CircleChartConfig) {
            self.config = config
            setupConfig()
        }
    }
}

// MARK: - Setups
extension CircleChart.ViewModel {
    private func setupConfig() {
        let total: CGFloat = config.data.reduce(.zero, { $0 + $1.value })
        
        var stroke: CGFloat = config.strokeMin + config.strokeDiff * CGFloat(config.data.count - 1)
        var lastestEnd: CGFloat = .zero
        
        var arcs: [ArcConfig] = []
        var subtitles: [SubtitleConfig] = []
        
        for datum in config.data {
            let percentage = datum.value / total
            let end = lastestEnd + percentage
            
            let arc = ArcConfig(start: lastestEnd, end: end, stroke: stroke, color: datum.color)
            let subtitle = SubtitleConfig(title: datum.title, color: datum.color)
            
            arcs.append(arc)
            subtitles.append(subtitle)
            
            print(stroke)
            stroke -= config.strokeDiff
            lastestEnd = end
        }
        
        valuesConfig = (arcs.reversed(), subtitles)
    }
}
