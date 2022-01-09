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
            DSColor.background.rawValue
            Text("Hello world from SwiftUI!").foregroundColor(.white)
        }
        .confirmationDialog("Operation type to add", isPresented: $viewModel.operationOptions, titleVisibility: .visible, actions: {
            Button("Cash In", action: viewModel.addCashIn)
            Button("Cash Out", action: viewModel.addCashOut)
            Button("Cancel", role: .cancel, action: viewModel.addCancel)
        })
        .edgesIgnoringSafeArea([.top, .bottom])
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
                        .frame(width: 40, height: 40)
                        .shadow(color: .black, radius: 16)
                    Text("BA")
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.headline)
                }
                Spacer(minLength: DSSpace.smallS.rawValue)
                VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                    Text("Breno Aquino")
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(.headline)
                    Text("Charles Inc.")
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
