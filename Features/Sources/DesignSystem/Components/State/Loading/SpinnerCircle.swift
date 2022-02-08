//
//  SpinnerCircle.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import SwiftUI

struct SpinnerCircle: View {
    
    let start: CGFloat
    let end: CGFloat
    let angle: Angle
    
    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
            .rotationEffect(angle)
    }
}

#if DEBUG
// MARK: - Preview
struct SpinnerCircle_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerCircle(start: .zero, end: 0.5, angle: .degrees(180))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
#endif
