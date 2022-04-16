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
        VStack(spacing: .zero) {
            GeometryReader { reader in
                ZStack(alignment: .topLeading) {
                    ColumnsVerticalAxis(titles: viewModel.verticalTitles)
                        .frame(height: reader.size.height - DSColumnsChart.horizontalAxisHeight)
                    
                    ColumnsSubtitles(titles: viewModel.horizontalTitles)
                        .frame(width: reader.size.width - DSColumnsChart.verticalAxisWidth)
                        .offset(x: DSColumnsChart.verticalAxisWidth)
                    
                    Columns(offset: viewModel.offsets,
                            onTap: { index in
                        viewModel.select(index: index)
                    })
                    .frame(
                        width: reader.size.width - DSColumnsChart.verticalAxisWidth,
                        height: reader.size.height -
                        DSColumnsChart.horizontalAxisHeight -
                        lineHeight(height: reader.size.height)
                    )
                    .offset(
                        x: DSColumnsChart.verticalAxisWidth,
                        y: halfLineHeight(height: reader.size.height)
                    )
                    .overlay {
                        columnSelection(
                            size: reader.size,
                            title: "R$ 2,0K",
                            subtitle: "Jan 2022",
                            index: viewModel.selectedIndex
                        )
                    }
                }
            }
        }
        .padding(.top, DSSpace.smallL.rawValue)
        .padding(.bottom, DSSpace.smallM.rawValue)
        .padding(.horizontal, DSSpace.smallM.rawValue)
    }
    
    private func columnSelection(size: CGSize, title: String, subtitle: String, index: Int) -> some View {
        ColumnsSelection(title: title, subtitle: subtitle)
            .frame(width: DSColumnsChart.selectionWidth, height: DSColumnsChart.selectionHeight)
            .offset(
                x: DSColumnsChart.verticalAxisWidth -
                (size.width - DSColumnsChart.verticalAxisWidth) / .two +
                halfColumnWidth(width: size.width) +
                CGFloat(index) * columnWidth(width: size.width),
                y: halfLineHeight(height: size.height) +
                halfColumnsViewHeight(height: size.height) -
                columnsViewHeight(height: size.height) *
                viewModel.offsets[index] -
                DSColumnsChart.selectionHeight / .two
            )
    }
    
    // MARK: Utils
    private func lineHeight(height: CGFloat) -> CGFloat {
        (height - DSColumnsChart.horizontalAxisHeight) / CGFloat(viewModel.verticalTitles.count)
    }
    
    private func halfLineHeight(height: CGFloat) -> CGFloat {
        lineHeight(height: height) / .two
    }
    
    private func columnWidth(width: CGFloat) -> CGFloat {
        (width - DSColumnsChart.verticalAxisWidth) / CGFloat(viewModel.horizontalTitles.count)
    }
    
    private func halfColumnWidth(width: CGFloat) -> CGFloat {
        columnWidth(width: width) / .two
    }
    
    private func columnsViewHeight(height: CGFloat) -> CGFloat {
        height - DSColumnsChart.horizontalAxisHeight - lineHeight(height: height)
    }
    
    private func halfColumnsViewHeight(height: CGFloat) -> CGFloat {
        columnsViewHeight(height: height) / .two
    }
}

#if DEBUG
// MARK: - Preview
struct ColumnsChart_Previews: PreviewProvider {
    
    static var previews: some View {
        return ColumnsChart()
            .frame(height: 240)
            .background(.black)
            .padding()
            .background(.gray)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
