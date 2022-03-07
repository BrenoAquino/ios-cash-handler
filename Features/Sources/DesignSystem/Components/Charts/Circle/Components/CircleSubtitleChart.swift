//
//  CircleSubtitleChart.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct CircleSubtitleChart: View {
    
    @State var subtitles: [SubtitleConfig]
    @State private var elementsSize: [SubtitleConfig: CGSize] = [:]
    
    var body : some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(computeRows(), id: \.self) { row in
                HStack(spacing: 16) {
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
    }
    
    private func cell(title: String, color: Color) -> some View {
        HStack {
            Circle()
                .foregroundColor(color)
            Text(title)
        }
    }
    
    func computeRows() -> [[SubtitleConfig]] {
        var rows: [[SubtitleConfig]] = [[]]
        var currentRow = 0
        var remainingWidth = UIScreen.main.bounds.width
        
        for element in subtitles {
            let elementSize = elementsSize[element, default: CGSize(width: UIScreen.main.bounds.width, height: 1)]
            
            if remainingWidth - (elementSize.width + 16) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = UIScreen.main.bounds.width
            }
            
            remainingWidth = remainingWidth - (elementSize.width + 16)
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
    }
}
#endif
