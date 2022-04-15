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
                ColumnsVerticalAxis(titles: viewModel.verticalTitles)
                    .frame(height: reader.size.height - DSColumnsChart.horizontalAxisHeight)
                
                ColumnsSubtitles(titles: viewModel.horizontalTitles)
                    .frame(width: reader.size.width - DSColumnsChart.verticalAxisWidth)
                    .offset(x: DSColumnsChart.verticalAxisWidth)
                
                Columns(offset: viewModel.offsets)
                    .frame(width: reader.size.width - DSColumnsChart.verticalAxisWidth,
                           height: reader.size.height - .two * DSColumnsChart.horizontalAxisHeight)
                    .offset(x: DSColumnsChart.verticalAxisWidth,
                            y: DSColumnsChart.horizontalAxisHeight / .two)
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsChart_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsChart()
            .frame(height: 240)
            .background(.black)
//            .padding()
            .background(.gray)
            .preferredColorScheme(.dark)
//            .previewLayout(.sizeThatFits)
    }
}
#endif
