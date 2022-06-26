//
//  ApiNetwork.swift
//  CurrencyConversion
//
//  Created by Mariam Abdelhamid on 6/25/22.
//

import Foundation

enum MethodTypes: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: Int, Error{
    case error400 = 400
    case error401 = 401
    case error404 = 404
    case error429 = 429
    
    var errorMessage :String {
        
        if self.rawValue > 499 && self.rawValue < 600 {
        return "We have failed to process your request. (You can contact us anytime)"
        }
        switch self {
        case .error400:
             return "The request was unacceptable, often due to missing a required parameter"
        case .error401:
            return "No valid API key provided."
        case .error404:
            return "The requested resource doesn't exist."
        case .error429:
            return "API request limit exceeded. See section Rate Limiting for more info."
            
        }

    }
    
    
}
class ApiNetwork{
    
    static let  shared = ApiNetwork()
    
    private init(){
        
    }
    
    func requestApi(urlString: String , methodTypes: MethodTypes, completionHandler: @escaping (Result<Data, Error>) -> Void){
        
        let headers = [
            "apikey": "ZxL01VTnWChtwlS4d7agITy8JF99IIQt"
        ]
        
        guard let url = URL(string: urlString) else { return  }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = methodTypes.rawValue
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode

                let errorTypes = ErrorTypes(rawValue: statusCode)?.errorMessage
                completionHandler(.failure(NSError(domain: errorTypes ?? "", code: ErrorTypes(rawValue: statusCode)?.rawValue ?? 0) as Error))
                
                
            }
            
            guard let data = data else {
                return
            }
            completionHandler(.success(data))
          
        })
        task.resume()
    }
    
}
