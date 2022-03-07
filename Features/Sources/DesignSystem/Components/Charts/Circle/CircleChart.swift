//
//  CircleChart.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

public struct CircleChart: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(data: [CircleChartData]) {
        self.viewModel = ViewModel(data: data)
    }
    
    public var body: some View {
        VStack(spacing: DSSpace.normal.rawValue) {
            CircleCoreChart(arcs: viewModel.config.arcs)
            CircleSubtitleChart(subtitles: viewModel.config.subtitles)
        }
    }
}

#if DEBUG
// MARK: - Preview
struct CircleChart_Previews: PreviewProvider {
    
    static var previews: some View {
        let data: [CircleChartData] = [
            .init(title: "Lazer", value: 1, color: .orange),
            .init(title: "Tecnologia", value: 2, color: .yellow),
            .init(title: "Refeição", value: 3, color: .purple),
            .init(title: "Educação", value: 4, color: .gray),
        ]
        return CircleChart(data: data)
    }
}
#endif
