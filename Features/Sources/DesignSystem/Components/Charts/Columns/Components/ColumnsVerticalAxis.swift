//
//  ColumnsVerticalAxis.swift
//  
//
//  Created by Breno Aquino on 15/04/22.
//

import SwiftUI

struct ColumnsVerticalAxis: View {
    
    let titles: [String]
    
    init(titles: [String]) {
        self.titles = titles
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(titles, id: \.self) { title in
                lineElement(title: title)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func lineElement(title: String) -> some View {
        HStack(spacing: .zero) {
            Text(title)
                .font(DSFont.subheadline.rawValue)
                .foregroundColor(DSColor.contrast.rawValue)
                .frame(width: DSColumnsChart.verticalAxisWidth)
            
            DashLine()
                .stroke(style: StrokeStyle(lineWidth: DSColumnsChart.dashLineWidth, dash: DSColumnsChart.dashLineConfig))
                .foregroundColor(DSColor.contrast.rawValue)
                .frame(height: DSColumnsChart.dashLineHeight)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsVerticalAxis_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsVerticalAxis(titles: [
            "0", "2K", "4K", "6K", "8K", "10K"
        ])
            .frame(width: 300, height: 200)
            .background(.black)
            .padding(48)
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
