//
//  View+Banner.swift
//  
//
//  Created by Breno Aquino on 26/02/22.
//

import SwiftUI

public extension View {
    func banner(data: Binding<BannerData>, show: Binding<Bool>) -> some View {
        modifier(BannerModifier(data: data, show: show))
    }
}
