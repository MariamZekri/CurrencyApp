//
//  MockUpApiService.swift
//  CurrencyConversionTests
//
//  Created by Mariam Abdelhamid on 7/3/22.
//

@testable import CurrencyConversion

class MockUpApiService: ApiServiceProtocol{
    
    func getListSymbols(success: @escaping ([String: String]) -> Void,failure: @escaping (String) -> Void){
        success(["USD":"USD"])
        
    }
    
    func convertCurrency(from: String, to: String, amount: Double, success: @escaping (Double) -> Void,failure: @escaping (String) -> Void){
        
        if from == "USD" && to == "EGP" && amount > 0.0 {
            success(18)
        }else{
            failure("Not Supported")
        }
    }
    
    func lastThreeDaysCurrency(from: String, to: String, base: String, symbols: String, success: @escaping ([String : [String : Double]]) -> Void,failure: @escaping (String) -> Void){
        if base == "USD" && symbols == "EGP" {
            success(["2022-07-01" : ["USD" : 18]])
        }else{
            failure("Not Supported")
        }
    }
    
    func tenCurrencies(base: String, success: @escaping ([String: Double]) -> Void,failure: @escaping (String) -> Void){
        if base == "USD"{
            success(["EGP":18])
        }else{
            failure("Not Supported")
        }
    }
    
    
}

