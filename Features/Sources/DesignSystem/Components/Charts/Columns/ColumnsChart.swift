//
//  ColumnsChart.swift
//  
//
//  Created by Breno Aquino on 09/04/22.
//

import SwiftUI

public struct ColumnsChart: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init() {
        viewModel = ViewModel()
    }
    
    public var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .topLeading) {
                ColumnsAxes()
                
                Columns(offset: viewModel.offsets)
                    .frame(width: reader.size.width - 40, height: reader.size.height - 20)
                    .offset(x: 40)
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsChart_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsChart()
            .frame(width: 300, height: 200)
            .padding(48)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
