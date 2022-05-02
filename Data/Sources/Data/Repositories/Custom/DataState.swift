//
//  DataState.swift
//  
//
//  Created by Breno Aquino on 02/05/22.
//

import Foundation

enum DataState<Output> {
    case empty
    case loaded(data: Output, update: Date)
}
