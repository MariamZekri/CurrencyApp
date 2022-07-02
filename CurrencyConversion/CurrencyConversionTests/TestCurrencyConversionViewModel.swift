//
//  TestCurrencyConversionViewModel.swift
//  CurrencyConversionTests
//
//  Created by Mariam Abdelhamid on 7/3/22.
//

import XCTest
@testable import CurrencyConversion

class TestCurrencyConversionViewModel: XCTestCase {

    var viewModel: CurrencyConversionViewModel!
    var mockUpApiService : MockUpApiService!
    
    override func setUpWithError() throws {
        mockUpApiService = MockUpApiService()
        viewModel =  CurrencyConversionViewModel(apiService: mockUpApiService)
    }

    func testgetSymbols() throws {
        viewModel.getSymbols()
        XCTAssertEqual(try viewModel.symbolsBehaviour.value(), ["USD": "USD"])
    }
    
    func testupdateConvertCurrency() throws {

        viewModel.updateConvertCurrency(amountValue: 1.0, fromTxt: "USD", toTxt: "EGP")
        XCTAssertEqual(try viewModel.convertedResult.value(),18)
    }
}
