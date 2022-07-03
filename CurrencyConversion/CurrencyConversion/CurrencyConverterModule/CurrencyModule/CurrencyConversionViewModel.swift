//
//  CurrencyConversionViewModel.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/30/22.
//

import Foundation
import RxSwift

class CurrencyConversionViewModel{
   
    var symbolsBehaviour: BehaviorSubject<[String:String]> = BehaviorSubject(value: ["":""])
    var convertedResult: BehaviorSubject<Double> = BehaviorSubject(value: 0.0)
    
   private let apiService : ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    func getSymbols(){
        apiService.getListSymbols { symbols in
            self.symbolsBehaviour.onNext(symbols)
        } failure: {
            error in
            print(error)
        }
    }
    func updateConvertCurrency(amountValue: Double, fromTxt: String, toTxt: String) {
        if fromTxt != "" && toTxt != ""{
            apiService.convertCurrency(from: fromTxt, to: toTxt, amount:  amountValue) { result in
                self.convertedResult.onNext(result)
            } failure: { error in
                print(error)
            }
        }
    }

}
