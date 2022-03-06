//
//  CustomNavigationView.swift
//  
//
//  Created by Breno Aquino on 06/03/22.
//

import SwiftUI

public struct CustomNavigationBar<Content, ContentItems>: View where Content : View, ContentItems : View {
    
    private let title: String
    private let hasBack: Bool
    @ViewBuilder private let content: () -> Content
    @ViewBuilder private let items: () -> ContentItems?
    
    public init(_ title: String,
                hasBack: Bool = true,
                @ViewBuilder content: @escaping () -> Content,
                @ViewBuilder items: @escaping () -> ContentItems? = { nil }) {
        self.title = title
        self.hasBack = hasBack
        self.content = content
        self.items = items
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                print("onChanged", value)
            }
            .onEnded { value in
                print("onEnded", value)
            }
    }
    
    public var body: some View {
        ZStack {
            content()
                .safeAreaInset(edge: .top) {
                    Spacer()
                        .frame(height: 70)
                }
            NavigationBar(title: title, hasBack: hasBack, items: items)
        }
        .navigationBarHidden(true)
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar("Home") {
            Text("Screen Example")
        } items: {
            ImageAsset.add
        }
        .preferredColorScheme(.dark)
        
        CustomNavigationBar("Home", hasBack: false) {
            Text("Screen Example")
        } items: {
            ImageAsset.add
        }
        .preferredColorScheme(.dark)
    }
}
