//
//  Columns.swift
//  
//
//  Created by Breno Aquino on 10/04/22.
//

import SwiftUI

struct Columns: View {
    
    let onTapGesture: ((_ offsetIndex: Int) -> Void)?
    let offsets: [Double]
    
    init(offset: [Double], onTap: ((Int) -> Void)? = nil) {
        self.offsets = offset
        self.onTapGesture = onTap
    }
    
    var body: some View {
        GeometryReader { reader in
            HStack(alignment: .bottom, spacing: .zero) {
                ForEach(Array(zip(offsets.indices, offsets)), id: \.0) { index, value in
                    dotElement(
                        color: index.magnitude % .two == .zero ?
                        DSColor.contrast.rawValue :
                            DSColor.main.rawValue
                    )
                    .frame(maxWidth: .infinity)
                    .offset(
                        x: .zero,
                        y: reader.size.height / .two + DSColumnsChart.columnHeight / .two - reader.size.height * value
                    )
                    .onTapGesture {
                        self.onTapGesture?(Int(index.magnitude))
                    }
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
                LinearGradient(
                    gradient: Gradient(colors: DSColumnsChart.columnGradientColors),
                    startPoint: .top,
                    endPoint: .bottom
                )
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
