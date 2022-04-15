//
//  ColumnsVerticalAxis.swift
//  
//
//  Created by Breno Aquino on 15/04/22.
//

import SwiftUI

struct ColumnsVerticalAxis: View {
    
    @State var intervals: [Double]
    
    init(intervals: [Double]) {
        self.intervals = intervals
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            ForEach(intervals, id: \.self) { point in
                lineElement(point: point)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func lineElement(point: Double) -> some View {
        HStack(spacing: .zero) {
            Text(String(point))
                .frame(width: 40, height: 20)
            
            DashLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
                .frame(height: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsVerticalAxis_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsVerticalAxis(intervals: [0, 2, 4, 6, 8, 10])
            .frame(width: 300, height: 200)
            .background(.black)
            .padding(48)
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
