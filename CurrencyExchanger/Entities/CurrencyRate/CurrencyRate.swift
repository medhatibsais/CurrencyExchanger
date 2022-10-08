//
//  CurrencyRate.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import Foundation

/// Currency Rate
struct CurrencyRate: Codable {
    
    /// Code
    var code: String
    
    /// Amount
    var amount: Double
    
    /**
     Initializer
     */
    init() {
        
        // Default values
        self.code = ""
        self.amount = 0.0
    }
    
    /**
     Initializer
     - Parameter representation: Tuple of code and amount
     */
    init(representation: (code: String, amount: Double)) {
        self.init()
        
        // Set code
        self.code = representation.code
        
        // Set amount
        self.amount = representation.amount
    }
}
