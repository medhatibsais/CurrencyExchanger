//
//  Currency.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import Foundation

/// Currency
struct Currency: Codable {
    
    /// Code
    var code: String
    
    /// Name
    var name: String
    
    /// Rates
    var rates: [CurrencyRate]
    
    /**
     Initializer
     */
    init() {
        
        // Default values
        self.code = ""
        self.name = ""
        self.rates = []
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
}
