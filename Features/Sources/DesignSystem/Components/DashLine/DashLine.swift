//
//  DashLine.swift
//  
//
//  Created by Breno Aquino on 15/04/22.
//

import SwiftUI

struct DashLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: CGFloat.zero, y: .zero))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}
