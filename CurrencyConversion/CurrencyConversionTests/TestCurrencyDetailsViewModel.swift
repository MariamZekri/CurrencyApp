//
//  TestCurrencyDetailsViewModel.swift
//  CurrencyConversionTests
//
//  Created by Mariam Abdelhamid on 7/3/22.
//

import XCTest
@testable import CurrencyConversion
class TestCurrencyDetailsViewModel: XCTestCase {
    
    var viewModel: CurrencyDetailsViewModel!
    var mockUpApiService : MockUpApiService!

    override func setUpWithError() throws {
        mockUpApiService = MockUpApiService()
        viewModel =  CurrencyDetailsViewModel(apiService: mockUpApiService)
    }


    func testgetlastThreeDaysCurrency() throws {
        viewModel.getlastThreeDaysCurrency(fromCurrency: "USD", toCurrency: "EGP")
        XCTAssertEqual(try viewModel.historyBehaviour.value(), ["2022-07-01":["USD": 18]])
    }

    func testgetTenCurrencies() throws {
        viewModel.getTenCurrencies(baseCurrency: "USD")
        XCTAssertEqual(try viewModel.tenCurrenciesBehaviour.value(), ["EGP": 18])
    }
}
