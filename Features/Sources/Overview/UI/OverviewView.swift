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
            .navigationTitle(OverviewLocalizable.title)
            .background(DSColor.background.rawValue.ignoresSafeArea())
            .onAppear(perform: viewModel.fetchStats)
    }
    
    // MARK: View State
    private var state: some View {
         ZStack {
             switch viewModel.state {
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
            historic
            Spacer(minLength: DSSpace.bigL.rawValue)
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
    
    // MARK: Historic
    private var historic: some View {
        ColumnsChart(config: .init(
            max: 12.5,
            min: 0,
            verticalTitles: ["12,5K", "10K", "7.5K", "5K", "2.5K", "0"],
            values: [
                .init(value: 2, valueFormatted: "R$ 2,5K", abbreviation: "Jan", fullSubtitle: "Jan 2022"),
                .init(value: 2.5, valueFormatted: "R$ 2,5K", abbreviation: "Fev", fullSubtitle: "Fev 2022"),
                .init(value: 5, valueFormatted: "R$ 5,0K", abbreviation: "Mar", fullSubtitle: "Mar 2022"),
                .init(value: 10, valueFormatted: "R$ 10,0K", abbreviation: "Abr", fullSubtitle: "Abr 2022")
            ]))
            .padding(.leading, DSSpace.smallM.rawValue)
            .padding(.trailing, DSSpace.normal.rawValue)
            .padding(.vertical, DSSpace.smallS.rawValue)
            .frame(height: 336)
            .background(DSColor.secondBackground.rawValue)
            .cornerRadius(DSCornerRadius.normal.rawValue)
            .shadow(style: .medium)
            .padding(.horizontal, DSSpace.smallL.rawValue)
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
            OverviewView(viewModel: .init(statsUseCase: StatsUseCasePreview()))
        }
        .preferredColorScheme(.dark)
    }
}
#endif
