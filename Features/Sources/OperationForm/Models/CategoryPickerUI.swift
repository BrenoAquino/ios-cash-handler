//
//  CategoryPickerUI.swift
//  
//
//  Created by Breno Aquino on 13/02/22.
//

import Foundation
import DesignSystem

struct CategoryPickerUI: Identifiable, Hashable {
    let id: Int
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

extension CategoryPickerUI {
    static let placeholder = CategoryPickerUI(id: -1, name: "Ex: Refeição")
}
