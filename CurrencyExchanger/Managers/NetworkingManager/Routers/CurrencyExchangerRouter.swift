//
//  CurrencyExchangerRouter.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import Alamofire

/// Currency Exchanger Router
enum CurrencyExchangerRouter: URLRequestConvertible {
    
    /// Get Currencies
    case getCurrencies(parameters: Parameters)
    
    /// Get Currency Rates
    case getCurrencyRates(parameters: Parameters)
    
    /// Method
    var method: HTTPMethod {
        switch self {
        case .getCurrencies, .getCurrencyRates:
            return .get
        }
    }
    
    /// Path
    var path: String {
        switch self {
        case .getCurrencies:
            return "currencies.json"
        case .getCurrencyRates:
            return "latest.json"
        }
    }
    
    /// Base URL String
    var baseURLString: String {
        return "https://openexchangerates.org/api/"
    }
    
    /**
     URL Request
     */
    func asURLRequest() throws -> URLRequest {
        
        // URL
        let url = try self.baseURLString.asURL()
        
        // Setup URL request
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = ["Accept": "application/json"]
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        // Encode the requests with its own parameters
        switch self {
        case .getCurrencies(let parameters):
            
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .getCurrencyRates(let parameters):
            
            urlRequest = try URLEncoding(arrayEncoding: URLEncoding.ArrayEncoding.noBrackets).encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
