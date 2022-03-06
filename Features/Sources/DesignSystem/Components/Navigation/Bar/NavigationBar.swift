//
//  NavigationBar.swift
//  
//
//  Created by Breno Aquino on 01/03/22.
//

import SwiftUI

public struct NavigationBar<Content>: View where Content : View {
    
    let title: String
    let hasBack: Bool
    @ViewBuilder private let items: () -> Content?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(title: String = .empty,
                hasBack: Bool = true,
                @ViewBuilder items: @escaping () -> Content? = { nil }) {
        self.title = title
        self.hasBack = hasBack
        self.items = items
    }
    
    public var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(.all)
            
            HStack {
                if hasBack {
                    NavigationItem {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            ImageAsset.back
                                .tint(DSColor.primaryText.rawValue)
                        }
                    }
                }
                
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
            .padding(.horizontal, DSSpace.smallL.rawValue)
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
        
        NavigationBar(title: "Featured", hasBack: false) {
            Image(systemName:"magnifyingglass")
        }
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
