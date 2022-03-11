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
        VStack(alignment: .leading, spacing: DSSpace.smallM.rawValue) {
            Text("Tecnologia")
                .foregroundColor(DSColor.primaryText.rawValue)
                .font(DSFont.subheadlineLarge.rawValue)
            
            VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                Text(categoryOverview.expense)
                    .foregroundColor(DSColor.primaryText.rawValue)
                    .font(DSFont.title2.rawValue)
                
                LineBar(config: .init(percentage: categoryOverview.expensePercentage,
                                      color: Color(rgba: 0xD86239FF),
                                      backgroundColor: .gray))
                    .frame(height: 2)
            }
            
            VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
                Text(categoryOverview.count)
                    .foregroundColor(DSColor.primaryText.rawValue)
                    .font(DSFont.title2.rawValue)
                
                LineBar(config: .init(percentage: categoryOverview.countPercentage,
                                      color: .orange,
                                      backgroundColor: .gray))
                    .frame(height: 2)
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
            .padding()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
