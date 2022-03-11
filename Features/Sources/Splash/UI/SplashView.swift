//
//  SplashView.swift
//  
//
//  Created by Breno Aquino on 11/03/22.
//

import SwiftUI
import DesignSystem

public struct SplashView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .onAppear(perform: viewModel.fetchData)
    }
    
    // MARK: View State
    private var content: some View {
         ZStack {
             switch viewModel.stateHandler.state {
             case .failure:
                 EmptyView()
                     .defaultTransition()
                 
             default:
                 ViewState.loadingView(background: .opaque)
                     .defaultTransition()
             }
         }
     }
}

#if DEBUG
// MARK: - Preview
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(viewModel: .init(categoriesUseCase: CategoriesUseCasePreview(),
                                    paymentMethods: PaymentMethodsUseCasePreview()))
            .preferredColorScheme(.dark)
    }
}
#endif
