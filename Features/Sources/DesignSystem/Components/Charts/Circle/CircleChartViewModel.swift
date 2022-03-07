//
//  CircleCoreChartViewModel.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

extension CircleChart {
    final class ViewModel: ObservableObject {
        typealias Config = (arcs: [ArcConfig], subtitles: [SubtitleConfig])
        
        let data: [CircleChartData]
        
        // MARK: Publishers
        @Published private(set) var config: Config = ([], [])
        
        // MARK: Inits
        init(data: [CircleChartData]) {
            self.data = data
            setupConfig()
        }
    }
}

// MARK: - Setups
extension CircleChart.ViewModel {
    private func setupConfig() {
        let total: CGFloat = data.reduce(.zero, { $0 + $1.value })
        
        var stroke: CGFloat = DSCircleChart.strokeMin + DSCircleChart.strokeDiff * CGFloat(data.count)
        var lastestEnd: CGFloat = .zero
        
        var arcs: [ArcConfig] = []
        var subtitles: [SubtitleConfig] = []
        
        for datum in data {
            let percentage = datum.value / total
            let end = lastestEnd + percentage
            
            let arc = ArcConfig(start: lastestEnd, end: end, stroke: stroke, color: datum.color)
            let subtitle = SubtitleConfig(title: datum.title, color: datum.color)
            
            arcs.append(arc)
            subtitles.append(subtitle)
            
            stroke -= DSCircleChart.strokeDiff
            lastestEnd = end
        }
        
        config = (arcs.reversed(), subtitles)
    }
}
