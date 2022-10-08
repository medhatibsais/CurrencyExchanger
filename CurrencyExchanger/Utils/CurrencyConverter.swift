//
//  CurrencyConverter.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import Foundation

/// Currency Converter
class CurrencyConverter {
    
    /**
     Exchange
     - Parameter amount: Double, the amount needed to be converted
     - Parameter from: String, the currency to convert from it
     - Parameter to: String, the currency to convert to it
     - Returns: Optional double, in case of any missed values
     */
    class func exchange(amount: Double, from: String = SystemUtils.baseCurrency, to: String) -> Double? {
        
        // Get currency and get the rate of the second currency depending of the code, then get the conversion amount
        if let currency = CurrencyCachingManager.shared.getCurrency(for: from), let foreignCurrencyRate = currency.rates.first(where: { $0.code == to })?.amount {
            
            // Calculate and return the result
            return amount * foreignCurrencyRate
        }
        
        return nil
    }
}
