//
//  MockedCurrency.swift
//  CurrencyExchangerTests
//
//  Created by Medhat Ibsais on 19/10/2022.
//

import Foundation

/// Currency
struct MockedCurrency: Codable {
    
    /// Code
    var code: String
    
    /// Name
    var name: String
    
    /**
     Initializer
     */
    init() {
        
        // Default values
        self.code = ""
        self.name = ""
    }
    
    /**
     Initializer
     - Parameter representation: Tuple of code and name
     */
    init(representation: (code: String, name: String)) {
        self.init()
        
        // Set code
        self.code = representation.code
        
        // Set name
        self.name = representation.name
    }
    
    func fetch(url: URL, using session: URLSessionProtocol = URLSession.shared, completionHandler: @escaping () -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {

                
                
            }
            
            completionHandler()
        }
        
        task.resume()
    }
}
