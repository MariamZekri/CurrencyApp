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
    
    private let apiService : ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiService()){
        self.apiService = apiService
    }
    
    func getlastThreeDaysCurrency(fromCurrency: String, toCurrency: String){
        
        let toDateAndFromDate = getFormattedDate()
        apiService.lastThreeDaysCurrency(from: toDateAndFromDate.1, to: toDateAndFromDate.0, base: fromCurrency, symbols: toCurrency, success: { result in
            self.historyBehaviour.onNext(result)
        }, failure: { error in
        
            self.historyBehaviour.onError(NSError(domain: error, code: -1))
    
        })
    }
    
    func getFormattedDate() -> (String,String) {
        let currentDate = Date()
        let previousDate = Calendar.current.date(byAdding: .day, value: -3, to: currentDate) ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let toDate = dateFormatter.string(from: currentDate)
        let fromDate = dateFormatter.string(from: previousDate)
        return (toDate,fromDate)
     }
    
    func getTenCurrencies(baseCurrency: String){
    
        apiService.tenCurrencies(base: baseCurrency, success: { result in
            self.tenCurrenciesBehaviour.onNext(result)
        }, failure: { error in
        
            self.tenCurrenciesBehaviour.onError(NSError(domain: error, code: -1))
        })
    }

}
