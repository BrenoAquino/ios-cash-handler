//
//  CircleChartData.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI

public struct CircleChartData {
    let title: String
    let value: CGFloat
    let color: Color
    
    public init(title: String, value: CGFloat, color: Color) {
        self.title = title
        self.value = value
        self.color = color
    }
}
