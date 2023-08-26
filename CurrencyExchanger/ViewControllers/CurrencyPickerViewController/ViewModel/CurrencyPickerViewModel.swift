//
//  CurrencyPickerViewModel.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Currency Picker View Model
class CurrencyPickerViewModel {
    
    /// Representables
    private var representables: [TableViewCellRepresentable]
    
    /// Filtered representables
    private var filteredRepresentables: [TableViewCellRepresentable]
    
    /// Currencies
    private var currencies: [Currency]
    
    /// Selected currency
    private var selectedCurrency: Currency
    
    /// Search text
    private var searchText: String
    
    /**
     Initializer
     - Parameter selectedCurrency: Currency
     */
    init(selectedCurrency: Currency) {
        
        // Set default values
        self.representables = []
        self.filteredRepresentables = []
        self.currencies = CurrencyCachingManager.shared.getCurrencies()
        self.selectedCurrency = selectedCurrency
        self.searchText = ""
        
        // Build representables
        self.buildRepresentables()
    }
    
    /**
     Build representables
     */
    private func buildRepresentables() {
        
        // Clear the representables list
        self.representables.removeAll()
        
        // Iterate over each currency, and its index
        for (index, currency) in self.currencies.enumerated() {
            
            // Init currency cell representable
            let currencyCellRepresentable = CurrencyPickerTableViewCellRepresentable(currency: currency, isSelected: self.selectedCurrency.code == currency.code)
            
            // Set item data index, this is for knowing the real index for this cell data inside the main list that contains the currency details
            currencyCellRepresentable.itemDataIndex = index
            
            // Set selector type, for unit testing purposes, to indicate a unique ID for the cell
            currencyCellRepresentable.selectorType = currency.code
            
            // Append to representables list
            self.representables.append(currencyCellRepresentable)
        }
        
        // Filter the representables if the search text is not empty
        if !self.searchText.isEmpty {
            self.filterContent(self.searchText)
        }
    }
    
    // MARK: - Actions
    
    /**
     Filter content
     - Parameter text: String
     */
    func filterContent(_ text: String) {
        
        // Set search text
        self.searchText = text
        
        // Set the filtered list based on the search text, if the cell title contains the name of the currency or its code
        self.filteredRepresentables = self.representables.filter({ ($0 as! CurrencyPickerTableViewCellRepresentable).search(text: text) })
    }
    
    /**
     Get currency
     - Parameter indexPath: IndexPath
     - Parameter Optional currency
     This is use the index path from the table cell to get the currency using the item data index that is stored inside the representable to know the exact location of the currency inside the currencies list
     */
    func getCurrency(at indexPath: IndexPath) -> Currency? {
        
        // Get representable, and check if the count of the currencies list is greater than the item data index, to be safe
        if let representable = self.representableForRow(at: indexPath) as? CurrencyPickerTableViewCellRepresentable, self.currencies.count > representable.itemDataIndex {
            
            // Return the currency
            return self.currencies[representable.itemDataIndex]
        }
        
        return nil
    }
    
    // MARK: - Data source
    
    /**
     Number of rows
     */
    func numberOfRows(in section: Int) ->Int {
        
        // Read from the filtered list if the search text is not empty
        return self.searchText.isEmpty ? self.representables.count : self.filteredRepresentables.count
    }
    
    /**
     Representable for row
     */
    func representableForRow(at indexPath: IndexPath) -> TableViewCellRepresentable? {
        
        // Check if the number of rows is greater that index path row
        if self.numberOfRows(in: indexPath.section) > indexPath.row {
            
            // Read from the filtered list if the search text is not empty
            if self.searchText.isEmpty {
                return self.representables[indexPath.row]
            }
            else {
                return self.filteredRepresentables[indexPath.row]
            }
        }
        
        return nil
    }
    
    /**
     Height for row
     */
    func heightForRow(at inedxPath: IndexPath) -> CGFloat {
        return self.representableForRow(at: inedxPath)?.cellHeight ?? 0.0
    }
}
