//
//  DataCacheConfig.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import Foundation

struct DataCacheConfig {
    enum RetrieveRule {
        case firstDataAfterReloadIfNeeded
        case firstReloadIfNeeded
    }
    
    let retrieveRule: RetrieveRule
    let cacheTime: TimeInterval
}
