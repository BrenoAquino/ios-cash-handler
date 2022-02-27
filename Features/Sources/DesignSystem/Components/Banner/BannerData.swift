//
//  BannerData.swift
//  
//
//  Created by Breno Aquino on 26/02/22.
//

import Foundation
import SwiftUI

public enum BannerType {
    case success
    case failure
    case info
    
    var color: Color {
        DSColor.secondBackground.rawValue
    }
}

public struct BannerData {
    public let title: String
    public let subtitle: String
    public let type: BannerType
    
    public init(title: String, subtitle: String, type: BannerType) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}

public struct BannerControl {
    public var show: Bool
    public var data: BannerData
    
    public init(show: Bool, data: BannerData) {
        self.show = show
        self.data = data
    }
}
