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
        let viewModel = CircleChart.ViewModel(data: [
            .init(title: "Lazer", value: 1, color: .orange),
            .init(title: "Tecnologia", value: 2, color: .yellow),
            .init(title: "Refeição", value: 3, color: .purple),
            .init(title: "Educação", value: 4, color: .gray),
//            .init(title: "Moradia", value: 0, color: .cyan)
        ])
        return CircleChart(viewModel: viewModel)
    }
}
#endif
