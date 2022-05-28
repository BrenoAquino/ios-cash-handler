//
//  MainTabView.swift
//  
//
//  Created by Breno Aquino on 11/03/22.
//

import SwiftUI
import DesignSystem

public struct MainTabView<Content>: View where Content : View {
    
    @ObservedObject private(set) var viewModel: MainTabViewModel
    @ViewBuilder private let content: () -> Content
    
    public init(viewModel: MainTabViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    public var body: some View {
        contentView
            .onAppear(perform: viewModel.fetchData)
    }
    
    // MARK: View State
    private var contentView: some View {
         ZStack {
             switch viewModel.state {
             case .loading:
                 ViewState.loadingView(background: .opaque)
                     .defaultTransition()
                 
             case .failure:
                 ErrorView()
                     .defaultTransition()
                 
             default:
                 TabView {
                     content()
                 }
                 .accentColor(DSColor.main.rawValue)
                 .defaultTransition()
             }
         }
     }
}

#if DEBUG
// MARK: - Preview
import Previews

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(viewModel: .init(categoriesUseCase: CategoriesUseCasePreview(),
                                     paymentMethods: PaymentMethodsUseCasePreview())) {
            EmptyView()
        }
    }
}
#endif
