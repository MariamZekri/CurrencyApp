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
    
    init(){
    }
    
    func getSymbols(){
        ApiService.getListSymbols { symbols in
            self.symbolsBehaviour.onNext(symbols)
        } failure: {
            error in
            print(error)
        }
    }
    func updateConvertCurrency(amountValue: Double, fromTxt: String, toTxt: String) {
        if fromTxt != "" && toTxt != ""{
            ApiService.convertCurrency(from: fromTxt, to: toTxt, amount:  amountValue) { result in
                self.convertedResult.onNext(result)
            } failure: { error in
                print(error)
            }
        }
    }

}
