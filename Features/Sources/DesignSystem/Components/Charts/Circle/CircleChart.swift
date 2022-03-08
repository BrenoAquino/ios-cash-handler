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
        GeometryReader { geometry in
            HStack(spacing: DSSpace.smallS.rawValue) {
                CircleCoreChart(arcs: viewModel.config.arcs)
                    .frame(width: geometry.size.width / 2)
                
                CircleSubtitleChart2(subtitles: viewModel.config.subtitles)
                    .frame(width: geometry.size.width / 2)
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct CircleChart_Previews: PreviewProvider {
    
    static var previews: some View {
        let data: [CircleChartData] = [
            .init(title: "2% • Saúde", value: 1, color: .init(rgba: 0xD86239FF)),
            .init(title: "4% • Assinatura", value: 2, color: .init(rgba: 0xF2CAB3FF)),
            .init(title: "6% • Moradia", value: 3, color: .init(rgba: 0x3E3F42FF)),
            .init(title: "8% • Tecnologia", value: 4, color: .init(rgba: 0x2F3136FF)),
            .init(title: "10% • Mobilidade", value: 5, color: .init(rgba: 0x9D9D9DFF)),
            .init(title: "12% • Refeição", value: 6, color: .init(rgba: 0x545453FF)),
            .init(title: "14% • Educação", value: 7, color: .init(rgba: 0xD86239FF)),
            .init(title: "16% • Outra Pessoa", value: 8, color: .init(rgba: 0xF2CAB3FF)),
            .init(title: "18% • Lazer", value: 9, color: .init(rgba: 0x3E3F42FF))
        ]
        
        return CircleChart(data: data)
            .preferredColorScheme(.dark)
    }
}
#endif
