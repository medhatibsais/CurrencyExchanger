//
//  CurrencyError.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 11/09/2022.
//

import Foundation

/// Currency Error
struct CurrencyError: Error {
    
    /// Status
    var status: Int
    
    /// Message
    var message: String
    
    /// Description
    var description: String
    
    /**
     Initializer
     */
    init() {
        
        // Default values
        self.status = 0
        self.message = ""
        self.description = ""
    }
    
    /**
     Initializer
     - Parameter representation: representation as dictionary
     */
    init(representation: [String: Any]) {
        self.init()
        
        // Set status
        if let value = representation[CodingKeys.status.rawValue] as? Int {
            self.status = value
        }
        
        // Set message
        if let value = representation[CodingKeys.message.rawValue] as? String {
            self.message = value
        }
        
        // Set description
        if let value = representation[CodingKeys.description.rawValue] as? String {
            self.description = value
        }
    }
    
    /// Coding Keys
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case description
    }
}
