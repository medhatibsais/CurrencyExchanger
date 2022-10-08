//
//  CurrencyExchangerModel.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import Alamofire

/// Currency Exchanger Model
class CurrencyExchangerModel {
    
    /// Request Tags
    enum RequestTags: String {
        case prettyprint
        case base
        case symbols
        case showAlternative    = "show_alternative"
        case showInactive       = "show_inactive"
        case appID              = "app_id"
    }
    
    /// Response Tags
    enum ResponseTags: String {
        case rates
        case error
    }
    
    /**
     Get currencies
     - Parameter completion: Completion block, that returns list of currencies
     */
    class func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        
        // Setup parameters
        var parameters: Parameters = self.getDefaultParameters()
        parameters.updateValue(false, forKey: Self.RequestTags.showInactive.rawValue)
        
        // Request
        Session.default.request(CurrencyExchangerRouter.getCurrencies(parameters: parameters)).response { response in
            
            // Check result
            switch response.result {
            case .success(let data):
                
                // Get data
                if let data = data {
                    
                    // Currencies
                    var currencies: [Currency] = []
                    
                    // json object
                    let jsonObject = SystemUtils.responseJSONSerializer(data: data)
                    
                    // Serialize object
                    if let jsonObject = jsonObject as? [String: String] {
                        
                        // Iterate over each json object
                        for (key, value) in jsonObject {
                            
                            // Append to currencies list
                            currencies.append(Currency(representation: (code: key, name: value)))
                        }
                    }
                    
                    // Check if there is an error
                    else if let hasError = jsonObject[Self.ResponseTags.error.rawValue] as? Bool, hasError {
                        
                        // Init currency error
                        let currencyError = CurrencyError(representation: jsonObject)
                        
                        // Call completion
                        completion(.failure(currencyError))
                        
                        return
                    }
                    
                    // Call completion
                    completion(.success(currencies))
                }
                else {
                    
                    // Create error
                    let error = AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)
                    
                    // Call completion
                    completion(.failure(error))
                }
                
            case .failure(let error):
                
                // Call completion
                completion(.failure(error))
            }
        }
    }
    
    /**
     Get currency rates
     - Parameter baseCurrency: String
     - Parameter symbols: List of strings, for needed symbols
     - Parameter completion: Completion block, that returns list of currency rates, and the base currency
     */
    class func getCurrencyRates(baseCurrency: String, symbols: [String], completion: @escaping (Result<(rates: [CurrencyRate], baseCurrency: String), Error>) -> Void) {
        
        // Setup parameters
        var parameters: Parameters = self.getDefaultParameters()
        parameters.updateValue(baseCurrency, forKey: RequestTags.base.rawValue)
        parameters.updateValue(symbols.joined(separator: ","), forKey: RequestTags.symbols.rawValue)
        
        // Request
        Session.default.request(CurrencyExchangerRouter.getCurrencyRates(parameters: parameters)).response { [baseCurrency] response in
            
            // Check result
            switch response.result {
            case .success(let data):
                
                // Get data
                if let data = data {
                    
                    // Currency rates
                    var currencyRates: [CurrencyRate] = []
                    
                    // Serialize object
                    let jsonObject = SystemUtils.responseJSONSerializer(data: data)
                    
                    // Get rates as dictionary of string and double
                    if let rates = jsonObject[Self.ResponseTags.rates.rawValue] as? [String: Double] {
                        
                        // Iterate over each rate
                        for (key, value) in rates {
                            
                            // Append to currency rates list
                            currencyRates.append(CurrencyRate(representation: (code: key, amount: value)))
                        }
                    }
                    
                    // Check if there is an error
                    else if let hasError = jsonObject[Self.ResponseTags.error.rawValue] as? Bool, hasError {
                        
                        // Init currency error
                        let currencyError = CurrencyError(representation: jsonObject)
                        
                        // Call completion
                        completion(.failure(currencyError))
                        
                        return
                    }
                    
                    // Call completion
                    completion(.success((rates: currencyRates, baseCurrency: baseCurrency)))
                }
                else {
                    
                    // Create error
                    let error = AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNilOrZeroLength)
                    
                    // Call completion
                    completion(.failure(error))
                }
                
            case .failure(let error):
                
                // Call completion
                completion(.failure(error))
            }
        }
    }
    
    /**
     Get default parameters
     - Returns: Parameters needed for the API request
     */
    private class func getDefaultParameters() -> Parameters {
        
        // Parameters
        var parameters: Parameters = Parameters()
        
        // Append needed values for the request
        parameters.updateValue(SystemUtils.appID, forKey: Self.RequestTags.appID.rawValue)
        parameters.updateValue(false, forKey: Self.RequestTags.prettyprint.rawValue)
        parameters.updateValue(false, forKey: Self.RequestTags.showAlternative.rawValue)
        
        return parameters
    }
}
