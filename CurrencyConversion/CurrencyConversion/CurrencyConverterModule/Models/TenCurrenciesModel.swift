//
//  TenCurrenciesModel.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 7/2/22.
//

import Foundation
struct TenCurrenciesModel: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

