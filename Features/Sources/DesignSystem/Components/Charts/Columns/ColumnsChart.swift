//
//  ColumnsChart.swift
//  
//
//  Created by Breno Aquino on 09/04/22.
//

import SwiftUI

public struct ColumnsChart: View {
    
    @ObservedObject private(set) var viewModel: ViewModel
    
    public init(config: ColumnsChartConfig) {
        viewModel = ViewModel(config: config)
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            GeometryReader { reader in
                ZStack(alignment: .topLeading) {
                    verticalAxis(size: reader.size)
                    subtitles(size: reader.size)
                    columns(size: reader.size)
                }
            }
        }
        .padding(.top, DSSpace.smallL.rawValue)
        .padding(.bottom, DSSpace.smallM.rawValue)
        .padding(.horizontal, DSSpace.smallM.rawValue)
    }
    
    // MARK: Axes
    private func verticalAxis(size: CGSize) -> some View {
        ColumnsVerticalAxis(titles: viewModel.verticalTitles)
            .frame(height: size.height - DSColumnsChart.horizontalAxisHeight)
    }
    
    private func subtitles(size: CGSize) -> some View {
        ColumnsSubtitles(titles: viewModel.horizontalTitles)
            .frame(width: size.width - DSColumnsChart.verticalAxisWidth)
            .offset(x: DSColumnsChart.verticalAxisWidth)
    }
    
    // MARK: Columns
    private func columns(size: CGSize) -> some View {
        Columns(offset: viewModel.offsets, onTap: { viewModel.select(index: $0) })
            .frame(
                width: size.width - DSColumnsChart.verticalAxisWidth,
                height: size.height -
                DSColumnsChart.horizontalAxisHeight -
                lineHeight(height: size.height)
            )
            .offset(
                x: DSColumnsChart.verticalAxisWidth,
                y: halfLineHeight(height: size.height)
            )
            .overlay {
                if let (index, value) = viewModel.selectedColumn {
                    columnSelection(
                        size: size,
                        title: value.valueFormatted,
                        subtitle: value.fullSubtitle,
                        index: index
                    )
                }
            }
    }
    
    // MARK: Floating Views
    private func columnSelection(size: CGSize, title: String, subtitle: String, index: Int) -> some View {
        ColumnsSelection(title: title, subtitle: subtitle)
            .frame(
                width: DSColumnsChart.selectionWidth,
                height: DSColumnsChart.selectionHeight
            )
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
        return ColumnsChart(config: .init(
            max: 12.5,
            min: 0,
            verticalTitles: ["12,5K", "10K", "7.5K", "5K", "2.5K", "0"],
            values: [
                .init(value: 2, valueFormatted: "R$ 2,5K", abbreviation: "Jan", fullSubtitle: "Jan 2022"),
                .init(value: 2.5, valueFormatted: "R$ 2,5K", abbreviation: "Fev", fullSubtitle: "Fev 2022"),
                .init(value: 5, valueFormatted: "R$ 5,0K", abbreviation: "Mar", fullSubtitle: "Mar 2022"),
                .init(value: 10, valueFormatted: "R$ 10,0K", abbreviation: "Abr", fullSubtitle: "Abr 2022")
            ]))
        .frame(height: 240)
        .background(.black)
        .padding()
        .background(.gray)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
#endif
