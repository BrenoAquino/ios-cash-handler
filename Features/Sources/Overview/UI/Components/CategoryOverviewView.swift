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
        HStack(alignment: .center) {
            element(title: "Total Entrada", value: overviewMont.income)
            element(title: "Total Saída", value: overviewMont.expense)
            element(title: "Acréscimo", value: overviewMont.refer)
        }
        .frame(maxWidth: .infinity)
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
            expense: "R$ 2800",
            expensePercentage: 0.75,
            count: "12 compras",
            countPercentage: 0.3
        ))
        .previewLayout(.sizeThatFits)
    }
}
#endif
