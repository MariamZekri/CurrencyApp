//
//  ApiService.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/25/22.
//

import Foundation

protocol ApiServiceProtocol{
    func getListSymbols(success: @escaping ([String: String]) -> Void,failure: @escaping (String) -> Void)
    func convertCurrency(from: String, to: String, amount: Double, success: @escaping (Double) -> Void,failure: @escaping (String) -> Void)
    func lastThreeDaysCurrency(from: String, to: String, base: String, symbols: String, success: @escaping ([String : [String : Double]]) -> Void,failure: @escaping (String) -> Void)
    func tenCurrencies(base: String, success: @escaping ([String: Double]) -> Void,failure: @escaping (String) -> Void)
}
class ApiService: ApiServiceProtocol{
    
    
     func getListSymbols(success: @escaping ([String: String]) -> Void,failure: @escaping (String) -> Void){
        
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
    
    func convertCurrency(from: String, to: String, amount: Double, success: @escaping (Double) -> Void,failure: @escaping (String) -> Void){
        
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
    
    func lastThreeDaysCurrency(from: String, to: String, base: String, symbols: String, success: @escaping ([String : [String : Double]]) -> Void,failure: @escaping (String) -> Void){
        
        if Reachability.isConnectedToNetwork(){
            ApiNetwork.shared.requestApi(urlString: "https://api.apilayer.com/fixer/timeseries?start_date=\(from)&end_date=\(to)&base=\(base)&symbols=\(symbols)", methodTypes: .get) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    
                    do {
                        let historyModel = try decoder.decode(HistoryModel.self, from: data)
                        success(historyModel.rates)
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
    
func tenCurrencies(base: String, success: @escaping ([String: Double]) -> Void,failure: @escaping (String) -> Void){
        
        if Reachability.isConnectedToNetwork(){
            ApiNetwork.shared.requestApi(urlString: "https://api.apilayer.com/fixer/latest?symbols=GBP%2CJYP%2C%20EUR%2CEGP%2CUSD%2CKWD%2CAUD%2CQAR%2CSAR%2C%20CNY%2CJPY&base=\(base)", methodTypes: .get) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    
                    do {
                        let tenCurrenciesModel = try decoder.decode(TenCurrenciesModel.self, from: data)
                        success(tenCurrenciesModel.rates)
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
