//
//  ColumnsHorizontalAxis.swift
//  
//
//  Created by Breno Aquino on 15/04/22.
//

import SwiftUI

struct ColumnsHorizontalAxis: View {
    
    @State var intervals: [Double]
    
    init(intervals: [Double]) {
        self.intervals = intervals
    }
    
    public var body: some View {
        HStack(alignment: .bottom) {
            ForEach(intervals, id: \.self) { point in
                lineElement(point: point)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func lineElement(point: Double) -> some View {
        VStack(spacing: .zero) {
            DashLine()
               .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
               .frame(width: 1)
            
            Text(String(point))
                .frame(width: 40, height: 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsHorizontalAxis_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsHorizontalAxis(intervals: [0, 2, 4, 6, 8, 10])
            .frame(width: 300, height: 200)
            .background(.black)
            .padding(48)
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
