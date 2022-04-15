//
//  ColumnsAxes.swift
//  
//
//  Created by Breno Aquino on 15/04/22.
//

import SwiftUI

struct ColumnsAxes: View {
    
    @State var points: [Double] = [0, 2, 4, 6, 8, 10]
    
    init() {}
    
    public var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .topLeading) {
                ColumnsVerticalAxis(intervals: points)
                    .frame(height: reader.size.height - 10)
                
                ColumnsHorizontalAxis(intervals: points)
                    .frame(width: reader.size.width - 20)
                    .offset(x: 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func lineElement(point: Double) -> some View {
        VStack {
            DashLine()
               .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
               .frame(width: 1)
            
            Text(String(point))
                .frame(width: 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsAxes_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsAxes()
            .frame(width: 350, height: 200)
            .background(.black)
            .padding(48)
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
