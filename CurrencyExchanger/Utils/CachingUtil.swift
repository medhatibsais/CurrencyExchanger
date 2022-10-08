//
//  CachingUtil.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import Foundation

/// Caching Util
class CachingUtil {
    
    /// Keys
    enum Keys: String {
        case currencies
    }
    
    /// User default standard object
    static private let userDefault = UserDefaults.standard
    
    /**
     Save currencies
     - Parameter currencies: List of currencies
     */
    class func saveCurrencies(currencies: [Currency]) {
        
        // Encode and save the data
        if let data = try? JSONEncoder().encode(currencies) {
            self.userDefault.set(data, forKey: Keys.currencies.rawValue)
        }
    }
    
    /**
     Get currencies
     - Returns: List of currencies
     */
    class func getCurrencies() -> [Currency] {
        
        // CurrenciesL list
        var currenciesList: [Currency] = []
        
        // Get data, and decode it to list of currencies
        if let data = self.userDefault.value(forKey: Keys.currencies.rawValue) as? Data, let currencies = try? JSONDecoder().decode([Currency].self, from: data) {
            
            // Set the list
            currenciesList = currencies
        }
        
        return currenciesList
    }
    
    /**
     Reset
     */
    class func reset() {
        
        // Iterate over each user default's keys and remove it
        for key in self.userDefault.dictionaryRepresentation().keys {
            self.userDefault.removeObject(forKey: key)
        }
    }
}
