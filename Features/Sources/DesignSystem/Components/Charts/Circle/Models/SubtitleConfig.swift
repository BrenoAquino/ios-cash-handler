//
//  SubtitleConfig.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

struct SubtitleConfig: Hashable {
    let title: String
    let color: Color
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(color)
    }
}
