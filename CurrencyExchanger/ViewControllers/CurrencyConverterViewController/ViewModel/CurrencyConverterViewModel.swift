//
//  CurrencyConverterViewModel.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Currency Converter View Model
class CurrencyConverterViewModel {
 
    /// Representables
    private var representables: [CollectionViewCellRepresentable]
    
    /// Currency
    private var currency: Currency!
    
    /**
     Initializer
     */
    init() {
            
        // Default values
        self.representables = []
    }
    
    /**
     Build representable
     */
    private func buildRepresentable() {
        
        // Clear representables list
        self.representables.removeAll()
        
        // Iterate over each rate
        for rate in self.currency.rates {
            
            // Setup, and append representable to the list
            self.representables.append(ExchangeInfoCollectionViewCellRepresentable(baseCurrencyCode: self.currency.code, rate: rate))
        }
    }
    
    // MARK: - Actions
    
    /**
     Set currency
     - Parameter currency: Currency
     */
    func setCurrency(_ currency: Currency) {
        
        // Set currency
        self.currency = currency
        
        // Build representable
        self.buildRepresentable()
    }
    
    // MARK: - Data source
    
    /**
     Number of items
     */
    func numberOfItems(in section: Int) -> Int {
        return self.representables.count
    }
    
    /**
     Representable for item
     */
    func representableForItem(at indexPath: IndexPath) -> CollectionViewCellRepresentable? {
        return self.numberOfItems(in: indexPath.section) > indexPath.row ? self.representables[indexPath.row] : nil
    }
}
