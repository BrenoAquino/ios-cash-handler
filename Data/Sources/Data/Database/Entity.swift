//
//  Entity.swift
//  
//
//  Created by Breno Aquino on 10/02/22.
//

import Foundation

public protocol Entity: AnyObject {
    associatedtype PrimaryKey: Hashable
    
    var primaryKey: PrimaryKey { get }
}
