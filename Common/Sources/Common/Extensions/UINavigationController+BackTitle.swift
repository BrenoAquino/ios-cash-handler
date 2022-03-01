//
//  UINavigationController+BackTitle.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        if #available(iOS 14.0, *) {
            navigationBar.topItem?.backButtonDisplayMode = .minimal
        } else {
            // FIXME: Remove back button Title
        }
    }
}
