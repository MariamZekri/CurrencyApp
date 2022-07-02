//
//  HistoryModel.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 7/1/22.
//

import Foundation
// MARK: - HistoryModel
struct HistoryModel: Codable {
    let base, endDate: String
    let rates: [String: [String: Double]]
    let startDate: String
    let success, timeseries: Bool

    enum CodingKeys: String, CodingKey {
        case base
        case endDate = "end_date"
        case rates
        case startDate = "start_date"
        case success, timeseries
    }
}
