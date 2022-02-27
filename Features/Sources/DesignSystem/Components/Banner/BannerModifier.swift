//
//  BannerModifier.swift
//  
//
//  Created by Breno Aquino on 26/02/22.
//

import SwiftUI

public struct BannerModifier: ViewModifier {
    
    @Binding var data: BannerData
    @Binding var show: Bool
    
    let duration: TimeInterval = 5
    
    public func body(content: Self.Content) -> some View {
        ZStack {
            content
            if show {
                banner
            }
        }
    }
    
    private var banner: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: DSSpace.smallM.rawValue) {
                    Text(data.title)
                        .font(DSFont.headline.rawValue)
                    Text(data.subtitle)
                        .font(DSFont.subheadline.rawValue)
                }
                Spacer()
            }
            .padding()
            .background(data.type.color)
            .cornerRadius(8)
        }
        .padding()
        .animation(.easeInOut)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .onTapGesture {
            withAnimation(Animation.easeInOut) {
                self.show = false
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                withAnimation {
                    self.show = false
                }
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct BannerModifier_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .frame(width: 100, height: 100)
            .modifier(
                BannerModifier(data: .constant(.init(title: "Title",
                                                     subtitle: "Subtitle banner",
                                                     type: .info)),
                               show: .constant(true))
            )
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
#endif
