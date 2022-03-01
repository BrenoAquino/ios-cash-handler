//
//  CategoryPickerUI.swift
//  
//
//  Created by Breno Aquino on 13/02/22.
//

import Foundation

struct CategoryPickerUI: Identifiable, Hashable {
    let id: String
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

extension CategoryPickerUI {
    static let placeholder = CategoryPickerUI(id: .empty, name: "Ex: Refeição")
}
