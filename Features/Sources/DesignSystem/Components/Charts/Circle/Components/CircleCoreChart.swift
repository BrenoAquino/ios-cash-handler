//
//  CircleCoreChart.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

struct CircleCoreChart: View {
    
    let arcs: [ArcConfig]
    
    var padding: CGFloat {
        (DSCircleChart.strokeMin + DSCircleChart.strokeDiff * CGFloat(arcs.count)) / .two
    }
    
    var body: some View {
        ZStack {
            ForEach(arcs, id: \.start) { data in
                ArcCircle(start: data.start,
                          end: data.end,
                          angle: .degrees(-90),
                          stroke: data.stroke)
                    .foregroundColor(data.color)
                    .shadow(style: .easy)
            }
        }
        .padding(padding)
    }
}

#if DEBUG
// MARK: - Preview
struct CircleCoreChart_Previews: PreviewProvider {
    
    static var previews: some View {
        let arcsConfigs: [ArcConfig] = [
            .init(start: 0.0, end: 0.1, stroke: 30, color: Color.orange),
            .init(start: 0.1, end: 0.3, stroke: 25, color: Color.gray),
            .init(start: 0.3, end: 0.6, stroke: 20, color: Color.blue),
            .init(start: 0.6, end: 1.0, stroke: 15, color: Color.purple)
        ].reversed()
        return CircleCoreChart(arcs: arcsConfigs)
    }
}
#endif
