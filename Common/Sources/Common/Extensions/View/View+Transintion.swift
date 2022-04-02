//
//  View+Transintion.swift
//  
//
//  Created by Breno Aquino on 28/02/22.
//

import SwiftUI

public extension View {
    
    func defaultTransition() -> some View {
        transition(.opacity.animation(.linear(duration: 0.3)))
    }
}
