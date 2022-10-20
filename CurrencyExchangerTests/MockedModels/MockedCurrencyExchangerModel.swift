//
//  MockedCurrencyExchangerModel.swift
//  CurrencyExchangerTests
//
//  Created by Medhat Ibsais on 19/10/2022.
//

import Foundation
@testable import CurrencyExchanger

class MockedCurrencyExchangerModel {
    
    class func fetch(url: URL, using session: URLSessionProtocol = URLSession.shared, completion: @escaping (Result<[Currency], Error>) -> Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
            
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
                    
                    // Call completion
                    completion(.success(currencies))
                    return
                }
            }
            
            completion(.failure(CurrencyError()))
        }
        
        task.resume()
    }
}
