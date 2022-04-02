//
//  CircleSubtitleChart.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI
import Common

struct CircleSubtitleChart: View {
    
    let spacing: CGFloat = 16
    
    @State var subtitles: [SubtitleConfig]
    @State private var elementsSize: [SubtitleConfig: CGSize] = [:]
    
    // MARK: View
    var body : some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(computeRows(geometry.size), id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(row, id: \.self) { element in
                            cell(title: element.title, color: element.color)
                                .fixedSize()
                                .readSize { size in
                                    elementsSize[element] = size
                                }
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .frame(minWidth: .zero, minHeight: .zero)
    }
    
    private func cell(title: String, color: Color) -> some View {
        HStack {
            Circle()
                .foregroundColor(color)
            Text(title)
        }
    }
    
    // MARK: Create Matrix
    func computeRows(_ size: CGSize = UIScreen.main.bounds.size) -> [[SubtitleConfig]] {
        var rows: [[SubtitleConfig]] = [[]]
        var currentRow: Int = .zero
        var remainingWidth = size.width
        
        for element in subtitles {
            let elementSize = elementsSize[element, default: CGSize(width: size.width, height: .one)]
            
            if remainingWidth - (elementSize.width + spacing) >= .zero {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + .one
                rows.append([element])
                remainingWidth = size.width
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }
        
        return rows
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
