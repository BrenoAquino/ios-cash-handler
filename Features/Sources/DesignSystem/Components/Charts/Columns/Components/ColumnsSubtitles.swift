//
//  ColumnsSubtitles.swift
//  
//
//  Created by Breno Aquino on 15/04/22.
//

import SwiftUI

struct ColumnsSubtitles: View {
    
    @State var titles: [String]
    
    init(titles: [String]) {
        self.titles = titles
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack(spacing: .zero) {
                ForEach(titles, id: \.self) { title in
                    lineElement(title: title)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func lineElement(title: String) -> some View {
        Text(title)
            .frame(height: DSColumnsChart.horizontalAxisHeight)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(DSColor.contrast.rawValue)
            .font(DSFont.subheadline.rawValue)
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsSubtitle_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsSubtitles(titles: [
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
