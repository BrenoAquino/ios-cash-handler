//
//  SpinnerCircle.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import SwiftUI

struct ArcCircle: View {
    
    let start: CGFloat
    let end: CGFloat
    let angle: Angle
    let stroke: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: stroke, lineCap: .round))
            .rotationEffect(angle)
    }
}

#if DEBUG
// MARK: - Preview
struct SpinnerCircle_Previews: PreviewProvider {
    static var previews: some View {
        ArcCircle(start: .zero, end: 0.5, angle: .degrees(180), stroke: 20)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
#endif
