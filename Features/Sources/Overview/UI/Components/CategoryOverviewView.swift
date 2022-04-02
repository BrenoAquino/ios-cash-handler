//
//  CategoryOverviewView.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import DesignSystem

struct CategoryOverviewView: View {
    
    @State var categoryOverview: CategoryOverviewUI
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryOverview.title)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.headline2.rawValue)
                .padding(.leading, DSSpace.smallM.rawValue)
            
            container
        }
    }
    
    private var container: some View {
        VStack(alignment: .leading, spacing: DSSpace.smallL.rawValue) {
            HStack {
                VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                    Text(categoryOverview.expense)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(DSFont.title2.rawValue)
                    
                    LineBar(config: .init(percentage: categoryOverview.expensePercentage,
                                          color: DSColor.main.rawValue,
                                          backgroundColor: .gray))
                    .frame(height: DSOverview.categoryOverviewLineHeight)
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                    Text(categoryOverview.count)
                        .foregroundColor(DSColor.primaryText.rawValue)
                        .font(DSFont.title2.rawValue)
                    
                    LineBar(config: .init(percentage: categoryOverview.countPercentage,
                                          color: DSColor.main.rawValue,
                                          backgroundColor: .gray))
                    .frame(height: DSOverview.categoryOverviewLineHeight)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(DSSpace.smallL.rawValue)
        .background(DSColor.secondBackground.rawValue)
        .cornerRadius(DSCornerRadius.normal.rawValue)
        .shadow(style: .medium)
    }
    
    private func element(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.subheadlineLarge.rawValue)
            
            Text(value)
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.title2.rawValue)
        }
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
// MARK: - Preview
struct CategoryOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        return CategoryOverviewView(categoryOverview: .init(
            title: "Tecnologia",
            expense: "R$ 2800",
            expensePercentage: 0.75,
            count: "12 compras",
            countPercentage: 0.3
        ))
            .background(.orange)
            .padding()
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
