//
//  UIApplication+endEditing.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
