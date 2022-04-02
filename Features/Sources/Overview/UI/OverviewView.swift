//
//  OverviewView.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import DesignSystem

public struct OverviewView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        state
            .navigationTitle("Overview")
            .background(DSColor.background.rawValue.ignoresSafeArea())
            .onAppear(perform: viewModel.fetchOperations)
    }
    
    // MARK: View State
    private var state: some View {
         ZStack {
             switch viewModel.stateHandler.state {
             case .loading:
                 ViewState.loadingView(background: .opaque)
                     .defaultTransition()
             default:
                 content
                     .defaultTransition()
             }
         }
     }
    
    // MARK: Content
    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer(minLength: DSSpace.normal.rawValue)
            title
            Spacer(minLength: DSSpace.smallM.rawValue)
            overviewMonth
            Spacer(minLength: DSSpace.smallM.rawValue)
            categories
            Spacer(minLength: DSSpace.bigL.rawValue)
        }
    }
    
    // MARK: Title
    private var title: some View {
        HStack(alignment: .center) {
            Text(viewModel.month)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.title.rawValue)
            
            Text(viewModel.year)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.subheadline.rawValue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, DSSpace.normal.rawValue)
    }
    
    // MARK: OverviewMonth
    private var overviewMonth: some View {
        OverviewMonthView(overviewMont: viewModel.overviewMonth)
            .padding()
    }
    
    // MARK: Categories
    private var categories: some View {
        ForEach(viewModel.categoriesOverview) { element in
            CategoryOverviewView(categoryOverview: element)
                .frame(maxWidth: .infinity)
                .padding(.bottom, DSSpace.smallL.rawValue)
        }
        .padding(.horizontal, DSSpace.smallL.rawValue)
    }
}

#if DEBUG
// MARK: - Preview
import Previews

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            OverviewView(viewModel: .init(operationsUseCase: OperationsUseCasePreview()))
        }
        .preferredColorScheme(.dark)
    }
}
#endif
