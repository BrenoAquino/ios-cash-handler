//
//  ContentView.swift
//  Charles
//
//  Created by Breno Aquino on 10/03/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MainTabCoordinator(viewModel: ViewModelFactory.coordinatorMainTab())
    }
}

#if DEBUG
// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
            .preferredColorScheme(.dark)
    }
}
#endif
