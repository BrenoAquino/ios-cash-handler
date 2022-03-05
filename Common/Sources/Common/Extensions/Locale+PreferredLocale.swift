//
//  Locale+PreferredLocale.swift
//  
//
//  Created by Breno Aquino on 04/03/22.
//

import Foundation

public extension Locale {
    static var preferred: Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
