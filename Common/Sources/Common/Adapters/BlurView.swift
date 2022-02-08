//
//  BlurView.swift
//  
//
//  Created by Breno Aquino on 08/02/22.
//

import SwiftUI

public struct BlurView: UIViewRepresentable {
    
    public init() {}
    
    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
//        uiView.effect = effect
    }
}
