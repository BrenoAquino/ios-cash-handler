//
//  Columns.swift
//  
//
//  Created by Breno Aquino on 10/04/22.
//

import SwiftUI

struct Columns: View {
    
    @State var offsets: [Double]
    
    init(offset: [Double]) {
        self.offsets = offset
    }
    
    public var body: some View {
        GeometryReader { reader in
            HStack(alignment: .bottom, spacing: 24) {
                ForEach(Array(zip(offsets.indices, offsets)), id: \.0) { index, value in
                    dotElement(
                        color: index.magnitude % 2 == 0 ?
                            DSColor.main.rawValue :
                            DSColor.contrast.rawValue
                    )
                    .offset(x: .zero, y: reader.size.height / 2 + DSColumnsChart.columnHeight / 2)
                    .offset(x: .zero, y: -reader.size.height * value)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func dotElement(color: Color) -> some View {
        Capsule()
            .fill(color)
            .frame(width: DSColumnsChart.columnWidth, height: DSColumnsChart.columnHeight)
            .mask(
                LinearGradient(gradient: Gradient(colors: [Color.black,
                                                           Color.black.opacity(0.25),
                                                           Color.black.opacity(0)]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
    }
}

#if DEBUG
// MARK: - Preview
struct Columns_Previews: PreviewProvider {
    
    static var previews: some View {
        return Columns(offset: [0.2, 0.4, 0.5, 0.7, 0.9])
            .frame(width: 300, height: 200)
            .padding(48)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
