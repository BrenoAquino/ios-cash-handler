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
        content
            .navigationTitle("Overview")
            .background(DSColor.background.rawValue.ignoresSafeArea())
    }
    
    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer(minLength: DSSpace.normal.rawValue)
            title
            Spacer(minLength: DSSpace.smallM.rawValue)
            overviewMonth
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
    
    // MARK: Categories
    private var categories: some View {
        VStack(spacing: DSSpace.smallM.rawValue) {
            ForEach(viewModel.categories, id: \.self) { row in
                HStack(spacing: DSSpace.smallM.rawValue) {
                    ForEach(row, id: \.self) { element in
                        CategoryOverviewView(categoryOverview: element)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(DSSpace.smallL.rawValue)
    }
    
    // MARK: Charts
    private var circleChart: some View {
        CircleChart(data: viewModel.data)
            .frame(width: 300)
    }
}

#if DEBUG
// MARK: - Preview
struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            OverviewView(viewModel: .init())
        }
        .preferredColorScheme(.dark)
    }
}
#endif
