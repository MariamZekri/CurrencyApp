//
//  ApiService.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/25/22.
//

import Foundation

class ApiService{
    
    static func getListSymbols(success: @escaping ([String: String]) -> Void,failure: @escaping (String) -> Void){
        
        if Reachability.isConnectedToNetwork(){
            ApiNetwork.shared.requestApi(urlString: "https://api.apilayer.com/fixer/symbols", methodTypes: .get) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    
                    do {
                        let symbolsObj = try decoder.decode(SymbolsModel.self, from: data)
                        success(symbolsObj.symbols)
                    } catch {
                        failure(error.localizedDescription)
                    }
                case .failure(let error):
                    failure(error.localizedDescription)
                }
            }
        }else{
            failure("No Internet Connection")
        }
    }
}
