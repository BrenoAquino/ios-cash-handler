//
//  DataCacheConfig.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import Foundation

public struct DataCacheConfig {
    public enum RetrieveRule {
        case firstDataAfterReloadIfNeeded
        case firstReloadIfNeeded
    }
    
    public let retrieveRule: RetrieveRule
    public let cacheTime: TimeInterval
}
