//
//  ArrowDown.swift
//  
//
//  Created by Breno Aquino on 16/04/22.
//

import SwiftUI

struct ArrowDown: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: CGFloat.zero, y: .zero))
        path.addLine(to: CGPoint(x: rect.width / .two, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: .zero))
        return path
    }
}
