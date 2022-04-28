//
//  CategoryOverviewView.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import DesignSystem

struct CategoryOverviewView: View {
    
    let categoryOverview: CategoryOverviewUI
    
    var body: some View {
        VStack(spacing: DSSpace.smallL.rawValue) {
            title
            lineStats(title: "Gasto", value: categoryOverview.expense, average: categoryOverview.averageExpense)
            lineStats(title: "Quantidade", value: categoryOverview.count, average: categoryOverview.averageCount)
        }
        .frame(width: 280)
        .padding(DSSpace.smallL.rawValue)
        .background(DSColor.secondBackground.rawValue)
        .cornerRadius(DSCornerRadius.normal.rawValue)
    }
    
    // MARK: Title Header
    private var title: some View {
        HStack {
            Text(categoryOverview.title)
            
            Spacer()
            
            VStack(spacing: .zero) {
                CircleChart(config: .init(hasSubtitle: false, strokeMin: 2, strokeDiff: 1, data: [
                    .init(title: .empty, value: categoryOverview.percentageExpense, color: DSColor.main.rawValue),
                    .init(title: .empty, value: categoryOverview.othersPercentage, color: DSColor.contrast.rawValue)
                ]))
                    .frame(width: 36, height: 36)
                
                Text(categoryOverview.percentageExpenseDescription)
                    .font(DSFont.footnote.rawValue)
            }
        }
    }
    
    // MARK: Line Stats
    private func lineStats(title: String, value: String, average: String) -> some View {
        VStack(alignment: .leading, spacing: DSSpace.smallM.rawValue) {
            Text(title)
                .font(DSFont.headline3.rawValue)
            
            HStack(spacing: DSSpace.smallL.rawValue) {
                stats(value: value, subtitle: "Total")
                    .frame(maxWidth: .infinity)
                stats(value: average, subtitle: "Média (M-1)")
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func stats(value: String, subtitle: String) -> some View {
        VStack {
            Text(value)
                .font(DSFont.headline2.rawValue)
                .foregroundColor(DSColor.primaryText.rawValue)
            
            Text(subtitle)
                .font(DSFont.footnote.rawValue)
                .foregroundColor(DSColor.primaryText.rawValue)
        }
    }
}

#if DEBUG
// MARK: - Preview
struct CategoryOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        return CategoryOverviewView(categoryOverview: .init(
            title: "Tecnologia",
            expense: "R$ 2800",
            averageExpense: "R$ 2300 / mês",
            percentageExpenseDescription: "55%",
            percentageExpense: 0.75,
            othersPercentage: 0.25,
            count: "12",
            averageCount: "6"
        ))
            .background(.orange)
            .padding()
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
