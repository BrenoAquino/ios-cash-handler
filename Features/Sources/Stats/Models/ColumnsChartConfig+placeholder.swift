//
//  ColumnsChartConfig+placeholder.swift
//  
//
//  Created by Breno Aquino on 28/05/22.
//

import DesignSystem

extension ColumnsChartConfig {
    static let placeholder: ColumnsChartConfig = .init(max: 12.5,
                                                       min: 0,
                                                       verticalTitles: ["12,5K", "10K", "7.5K", "5K", "2.5K", "0"],
                                                       values: [
                                                        .init(value: 2,
                                                              valueFormatted: "R$ 2,5K",
                                                              abbreviation: "Jan",
                                                              fullSubtitle: "Jan 2022"),
                                                        .init(value: 2.5,
                                                              valueFormatted: "R$ 2,5K",
                                                              abbreviation: "Fev",
                                                              fullSubtitle: "Fev 2022"),
                                                        .init(value: 5,
                                                              valueFormatted: "R$ 5,0K",
                                                              abbreviation: "Mar",
                                                              fullSubtitle: "Mar 2022"),
                                                        .init(value: 10,
                                                              valueFormatted: "R$ 10,0K",
                                                              abbreviation: "Abr",
                                                              fullSubtitle: "Abr 2022")
                                                       ])
}
