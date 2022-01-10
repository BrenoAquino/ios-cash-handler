//
//  HomeView.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            DSColor.background.rawValue.edgesIgnoringSafeArea([.top, .bottom])
            Text("Hello world from SwiftUI!").foregroundColor(.white)
        }
        .confirmationDialog(Localizable.Home.operationOptionsTitle,
                            isPresented: $viewModel.operationOptions,
                            titleVisibility: .visible,
                            actions: {
            Button(Localizable.Home.cashInOption, action: viewModel.addCashIn)
            Button(Localizable.Home.cashOutOption, action: viewModel.addCashOut)
            Button(Localizable.Common.cancel, role: .cancel, action: viewModel.addCancel)
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            profileBar
            addBar
        }
    }
    
    // MARK: Profile
    private var profileBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            HStack(spacing: DSSpace.smallM.rawValue) {
                ZStack() {
                    Circle()
                        .fill(.secondBackground)
                        .frame(width: DSHome.circleRadius, height: DSHome.circleRadius)
                        .shadow(style: .medium)
                    Text(Localizable.Home.userInitials)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.headline)
                }
                Spacer(minLength: DSSpace.smallS.rawValue)
                VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                    Text(Localizable.Home.userTitle)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.headline)
                    Text(Localizable.Home.companyTitle)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.subheadline)
                }
            }
        }
    }
    
    private var addBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: viewModel.selectAdd) {
                ImageAsset.add.tint(Color.white)
            }
        }
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .init())
    }
}
