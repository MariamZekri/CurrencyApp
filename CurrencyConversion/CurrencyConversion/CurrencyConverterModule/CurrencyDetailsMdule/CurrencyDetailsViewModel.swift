//
//  CurrencyDetailsViewModel.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 7/2/22.
//

import Foundation
import RxSwift

class CurrencyDetailsViewModel{
    var historyBehaviour: BehaviorSubject<[String : [String : Double]]> = BehaviorSubject(value: ["" : ["" : 0.0]])
    var tenCurrenciesBehaviour: BehaviorSubject<[String: Double]> = BehaviorSubject(value: ["" : 0.0])
    
    
    init(){
    }
    
    func getlastThreeDaysCurrency(fromCurrency: String, toCurrency: String){
        
        let currentDate = Date()
        let previousDate = Calendar.current.date(byAdding: .day, value: -3, to: currentDate) ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let toDate = dateFormatter.string(from: currentDate)
        let fromDate = dateFormatter.string(from: previousDate)
    
        ApiService.lastThreeDaysCurrency(from: fromDate, to: toDate, base: fromCurrency, symbols: toCurrency, success: { result in
            self.historyBehaviour.onNext(result)
        }, failure: { error in
        
            print(error)
        })
    }
    
    func getTenCurrencies(baseCurrency: String){
    
        ApiService.tenCurrencies(base: baseCurrency, success: { result in
            self.tenCurrenciesBehaviour.onNext(result)
        }, failure: { error in
        
            print(error)
        })
    }

}
