//
//  CustomNavigationView.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

public struct CustomNavigationBar<Content, ContentItems>: View where Content : View, ContentItems : View {
    
    private let title: String
    @ViewBuilder private let content: () -> Content
    @ViewBuilder private let items: () -> ContentItems?
    
    public init(_ title: String,
                @ViewBuilder content: @escaping () -> Content,
                @ViewBuilder items: @escaping () -> ContentItems? = { nil }) {
        self.title = title
        self.content = content
        self.items = items
    }
    
    public var body: some View {
        ZStack {
            content()
                .safeAreaInset(edge: .top) {
                    Spacer()
                        .frame(height: 70)
                }
            NavigationBar(title: title, items: items)
        }
        .navigationBarHidden(true)
    }
}


struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar("Home") {
            Text("Screen Example")
        } items: {
            Text("Button")
        }
    }
}
