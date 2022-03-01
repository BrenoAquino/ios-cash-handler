//
//  ViewState.swift
//  
//
//  Created by Breno Aquino on 20/01/22.
//

import SwiftUI

public enum ViewState {
    case content
    case finished
    case failure
    case loading
    case empty
}

public struct ViewStateHandler {
    public var state: ViewState
    
    public init(state: ViewState) {
        self.state = state
    }
    
    public mutating func content() { withAnimation { state = .content } }
    public mutating func finished() { withAnimation { state = .finished } }
    public mutating func failure() { withAnimation { state = .failure } }
    public mutating func loading() { withAnimation { state = .loading } }
    public mutating func empty() { withAnimation { state = .empty } }
}

public extension ViewState {
    static func loadingView(background: BackgroundMode) -> some View {
        LoadingView(backgroundMode: background)
    }
}
