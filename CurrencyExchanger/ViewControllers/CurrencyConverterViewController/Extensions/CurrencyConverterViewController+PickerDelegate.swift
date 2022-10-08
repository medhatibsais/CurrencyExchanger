//
//  CurrencyConverterViewController+PickerDelegate.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import Foundation

// MARK: -  Currency Picker View Controller Delegate
extension CurrencyConverterViewController: CurrencyPickerViewControllerDelegate {
    
    /**
     Did select item
     - Parameter item: Currency, the selected currency from the picker
     */
    func currencyPickerViewController(didSelectItem item: Currency) {
        
        // Did change selected currency
        self.didChangeSelectedCurrency(selectedCurrency: item)
    }
}
