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
                    DispatchQueue.main.async {
                        let decoder = JSONDecoder()
                        
                        do {
                            let symbolsObj = try decoder.decode(SymbolsModel.self, from: data)
                            success(symbolsObj.symbols)
                            
                        } catch {
                            failure(error.localizedDescription)
                        }
                      }
                   
                case .failure(let error):
                    failure(error.localizedDescription)
                }
            }
        }else{
            failure("No Internet Connection")
        }
    }
    
    static func convertCurrency(from: String, to: String, amount: Double, success: @escaping (Double) -> Void,failure: @escaping (String) -> Void){
        
        if Reachability.isConnectedToNetwork(){
            ApiNetwork.shared.requestApi(urlString: "https://api.apilayer.com/currency_data/convert?to=\(to)&from=\(from)&amount=\(amount)", methodTypes: .get) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    
                    do {
                        let convertModel = try decoder.decode(ConvertModel.self, from: data)
                        success(convertModel.result)
                    } catch {
                        failure(error.localizedDescription)
                    }
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
