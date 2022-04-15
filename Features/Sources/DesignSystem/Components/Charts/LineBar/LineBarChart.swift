//
//  LineBarChart.swift
//  
//
//  Created by Breno Aquino on 07/03/22.
//

import SwiftUI

public struct LineBarChart: View {
    
    @State var config: LineBarChartConfig
    
    public init(config: LineBarChartConfig) {
        self.config = config
    }
    
    public var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(config.backgroundColor)
            
            GeometryReader { reader in
                Capsule()
                    .foregroundColor(config.color)
                    .frame(width: reader.size.width * config.percentage, alignment: .leading)
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct LineBarChart_Previews: PreviewProvider {
    
    static var previews: some View {
        return LineBarChart(config: .init(percentage: 0.8,
                                     color: .orange,
                                     backgroundColor: .gray))
            .frame(width: 300, height: 20)
            .padding()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
#endif
