//
//  UINavigationController+BackTitle.swift
//  Charles
//
//  Created by Breno Aquino on 09/01/22.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
