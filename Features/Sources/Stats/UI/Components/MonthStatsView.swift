//
//  MonthStatsView.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI
import DesignSystem

struct MonthStatsView: View {
    
    var monthStats: MonthStatsUI
    
    // MARK: View
    var body: some View {
        HStack(alignment: .center) {
            element(title: StatsLocalizable.totalIncome, value: monthStats.income)
            element(title: StatsLocalizable.totalExpense, value: monthStats.expense)
            element(title: StatsLocalizable.percentageLastMonth, value: monthStats.refer)
        }
        .frame(maxWidth: .infinity)
        .padding(DSSpace.smallL.rawValue)
        .background(DSColor.secondBackground.rawValue)
        .cornerRadius(DSCornerRadius.normal.rawValue)
    }
    
    private func element(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: DSSpace.smallS.rawValue) {
            Text(title)
                .font(DSFont.subheadline.rawValue)
                .foregroundColor(DSColor.primaryText.rawValue)
            
            Text(value)
                .font(DSFont.headline2.rawValue)
                .foregroundColor(DSColor.primaryText.rawValue)
        }
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
// MARK: - Preview
struct OverviewMonthView_Previews: PreviewProvider {
    static var previews: some View {
        return MonthStatsView(monthStats: .init(income: "R$ 32K",
                                                expense: "R$ 4,32K",
                                                refer: "+5,32%"))
            .frame(width: UIScreen.main.bounds.width)
    }
}
#endif
