//
//  NavigationBar.swift
//  
//
//  Created by Breno Aquino on 01/03/22.
//

import SwiftUI

public struct NavigationBar<Content>: View where Content : View {
    
    var title = ""
    @ViewBuilder private let items: () -> Content?
    
    public init(title: String = "",
                @ViewBuilder items: @escaping () -> Content? = { nil }) {
        self.title = title
        self.items = items
    }
    
    public var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(.all)
            
            HStack(alignment: .center) {
                Text(title)
                    .font(DSFont.largeTitle.rawValue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                
                if let items = items {
                    NavigationItem {
                        items()
                    }
                }
            }
            .padding(.trailing, DSSpace.smallL.rawValue)
        }
        .frame(height: 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured") {
            Image(systemName:"magnifyingglass")
            Image(systemName:"magnifyingglass")
            Image(systemName:"magnifyingglass")
        }
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
