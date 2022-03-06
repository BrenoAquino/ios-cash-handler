//
//  CircleChart.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

struct CircleChart: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ForEach(viewModel.arcs, id: \.start) { data in
                ArcCircle(start: data.start,
                          end: data.end,
                          angle: .degrees(-90),
                          stroke: data.stroke)
                    .foregroundColor(data.color)
                    .frame(width: 100, height: 100)
                    .shadow(style: .easy)
            }
        }
    }
}

extension CircleChart {
    final class ViewModel: ObservableObject {
        
        struct ArcConfig {
            let start: CGFloat
            let end: CGFloat
            let stroke: CGFloat
            let color: Color
        }
        
        let data: [CGFloat]
        let colors: [Color] = [.orange, .gray, .blue, .purple]
        
        var arcs: [ArcConfig] {
            let diffStroke: CGFloat = 5
            let total: CGFloat = data.reduce(.zero, { $0 + $1 })
            var stroke: CGFloat = 10 + diffStroke * CGFloat(data.count)
            var lastEnd: CGFloat = .zero
            var arcs: [ArcConfig] = []
            
            for (index, datum) in data.enumerated() {
                let percent = datum / total
                let end = lastEnd + percent
                
                arcs.append(.init(
                    start: lastEnd,
                    end: end,
                    stroke: stroke,
                    color: colors[index % colors.count])
                )
                
                stroke -= diffStroke
                lastEnd = end
            }
            
            return arcs.reversed()
        }
        
        init(data: [CGFloat]) {
            self.data = data
        }
    }
}

#if DEBUG
// MARK: - Preview
struct CircleChart_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleChart(viewModel: .init(data: [1, 2, 3, 4]))
    }
}
#endif
