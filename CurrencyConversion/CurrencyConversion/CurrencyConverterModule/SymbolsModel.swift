//
//  SymbolsModel.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/25/22.
//

import Foundation

// MARK: - SymbolsModel
struct SymbolsModel: Codable {
    let success: Bool
    let symbols: [String: String]
}

