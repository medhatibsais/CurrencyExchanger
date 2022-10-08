//
//  CurrencyConverterViewController+TextFieldDelegate.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

// MARK: - Text Field Delegate
extension CurrencyConverterViewController: UITextFieldDelegate {
    
    /**
     Should change characters
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Check if the string value is equal to "."
        if string == "." {
            
            // Prevent from typing another dot if the old text is already have one
            if textField.text?.contains(".") ?? false {
                return false
            }
            
            return true
        }
        
        // Prevent from typing any non-decimal characters
        if !string.isEmpty, Double(string) == nil {
            return false
        }
        
        return true
    }
}
