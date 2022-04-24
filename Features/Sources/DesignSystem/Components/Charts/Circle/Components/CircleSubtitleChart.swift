//
//  CircleSubtitleChart.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import Common

struct CircleSubtitleChart: View {
    
    let subtitles: [SubtitleConfig]
    
    // MARK: View
    var body : some View {
        VStack(alignment: .leading, spacing: DSSpace.smallL.rawValue) {
            ForEach(subtitles, id: \.self) { subtitle in
                cell(title: subtitle.title, color: subtitle.color)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func cell(title: String, color: Color) -> some View {
        HStack {
            Circle()
                .foregroundColor(color)
                .frame(width: DSCircleChart.circleSubtitleSize.width, height: DSCircleChart.circleSubtitleSize.height)
            
            Text(title)
        }
    }
}

#if DEBUG
// MARK: - Preview
struct CircleSubtitleChart_Previews: PreviewProvider {
    
    static var previews: some View {
        let subtitlesConfig: [SubtitleConfig] = [
            .init(title: "Saúde", color: .orange),
            .init(title: "Assinatura", color: Color.gray),
            .init(title: "Moradia", color: Color.blue),
            .init(title: "Tecnologia", color: Color.purple),
            .init(title: "Mobilidade", color: .orange),
            .init(title: "Refeição", color: Color.gray),
            .init(title: "Educação", color: Color.blue),
            .init(title: "Outra Pessoa", color: Color.purple),
            .init(title: "Lazer", color: .orange)
        ]
        return CircleSubtitleChart(subtitles: subtitlesConfig)
            .background(Color.cyan)
            .previewLayout(.sizeThatFits)
    }
}
#endif
