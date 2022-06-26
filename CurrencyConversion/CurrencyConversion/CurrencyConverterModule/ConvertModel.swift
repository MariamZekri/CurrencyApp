//
//  ConvertModel.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/26/22.
//

import Foundation

// MARK: - ConvertModel
struct ConvertModel: Codable {
    let success: Bool
    let query: Query
    let info: Info
    let result: Double
}

// MARK: - Info
struct Info: Codable {
    let timestamp: Int
    let quote: Double
}

// MARK: - Query
struct Query: Codable {
    let from, to: String
    let amount: Double
}

