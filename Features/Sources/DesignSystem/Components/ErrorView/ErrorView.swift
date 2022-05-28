//
//  ErrorView.swift
//  
//
//  Created by Breno Aquino on 28/05/22.
//

import SwiftUI

public struct ErrorView: View {
    let title: String
    
    public init(title: String = "Algo deu errado. Tente novamente mais tarde.") {
        self.title = title
    }
    
    public var body: some View {
        Text(title)
    }
}

#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
#endif
