//
//  ColumnsSelection.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import SwiftUI

struct ColumnsSelection: View {
    
    @State var title: String
    @State var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            content
            arrow
        }
    }
    
    // MARK: Content
    private var content: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(title)
                .font(DSFont.headline2.rawValue)
                .foregroundColor(DSColor.primaryText.rawValue)
                
            Text(subtitle)
                .font(DSFont.subheadline.rawValue)
                .foregroundColor(DSColor.primaryText.rawValue)
        }
        .padding(.vertical, DSSpace.smallM.rawValue)
        .padding(.horizontal, DSSpace.smallL.rawValue)
        .background(DSColor.secondBackground.rawValue)
        .cornerRadius(DSCornerRadius.normal.rawValue)
        .shadow(style: .medium)
    }
    
    // MARK: Arrow
    private var arrow: some View {
        ArrowDown()
            .fill(DSColor.secondBackground.rawValue)
            .frame(width: DSColumnsChart.arrowWidth, height: DSColumnsChart.arrowHeight)
            .shadow(style: .medium)
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsSelection_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsSelection(title: "R$ 2954", subtitle: "Abr 2022")
            .padding()
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
