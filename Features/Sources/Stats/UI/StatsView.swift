//
//  StatsView.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import DesignSystem

public struct StatsView: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        state
            .navigationTitle(StatsLocalizable.title)
            .background(DSColor.background.rawValue.ignoresSafeArea())
            .toolbar {
                addBar
            }
            .onAppear(perform: viewModel.fetchStats)
    }
    
    // MARK: Navigation Bar
    private var addBar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: viewModel.selectAdd) {
                ImageAsset.add.tint(Color.white)
            }
        }
    }
    
    // MARK: View State
    private var state: some View {
         ZStack {
             switch viewModel.state {
             case .loading:
                 ViewState.loadingView(background: .opaque).defaultTransition()
             case .failure:
                 ErrorView().defaultTransition()
             case .content:
                 content.defaultTransition()
             default:
                 EmptyView().defaultTransition()
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
            historic
            Spacer(minLength: DSSpace.bigS.rawValue)
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
        MonthStatsView(monthStats: viewModel.overviewMonth)
            .padding()
            .shadow(style: .medium)
    }
    
    // MARK: Historic
    private var historic: some View {
        ZStack {
            ColumnsChart(config: viewModel.historicConfig)
                .padding(.leading, DSSpace.smallM.rawValue)
                .padding(.trailing, DSSpace.normal.rawValue)
                .padding(.vertical, DSSpace.smallS.rawValue)
                .frame(height: DSStats.heightColumns)
                .background(DSColor.secondBackground.rawValue)
                .cornerRadius(DSCornerRadius.normal.rawValue)
                .blur(radius: !viewModel.hasDataForColumn ? DSBlurRadius.normal.rawValue : .zero)
                .shadow(style: .medium)
                .padding(.horizontal, DSSpace.smallL.rawValue)
            
            if !viewModel.hasDataForColumn {
                Text(StatsLocalizable.emptyDataColumn)
                    .multilineTextAlignment(.center)
                    .font(DSFont.subheadlineLarge.rawValue)
                    .padding(DSSpace.normal.rawValue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
    // MARK: Categories
    private var categories: some View {
        VStack(alignment: .leading) {
            Text(StatsLocalizable.categoryTitleSection)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.title.rawValue)
                .padding(.horizontal, DSSpace.normal.rawValue)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .zero) {
                    ForEach(viewModel.categoriesOverview) { element in
                        CategoryStatsView(categoryOverview: element)
                            .padding(.bottom, DSSpace.smallL.rawValue)
                    }
                    .padding(.horizontal, DSSpace.smallL.rawValue)
                }
            }
            .shadow(style: .medium)
        }
    }
}

#if DEBUG
// MARK: - Preview
import Previews

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            StatsView(viewModel: .init(statsUseCase: StatsUseCasePreview()))
        }
        .preferredColorScheme(.dark)
    }
}
#endif
