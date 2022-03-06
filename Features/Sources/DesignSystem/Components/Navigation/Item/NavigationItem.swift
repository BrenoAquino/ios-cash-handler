//
//  NavigationItem.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

public struct NavigationItem<Content>: View where Content : View {
    
    @ViewBuilder private let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        content()
            .foregroundColor(DSColor.primaryText.rawValue)
            .frame(width: 24, height: 24)
            .cornerRadius(10)
            .padding(4)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

struct NavigationItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationItem {
            Image(systemName: "plus")
        }
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
