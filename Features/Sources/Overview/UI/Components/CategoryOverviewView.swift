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
        EmptyView()
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
