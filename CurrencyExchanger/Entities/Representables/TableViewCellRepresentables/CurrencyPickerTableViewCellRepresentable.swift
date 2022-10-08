//
//  CurrencyPickerTableViewCellRepresentable.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Currency Picker Table View Cell Representable
class CurrencyPickerTableViewCellRepresentable: TableViewCellRepresentable {
    
    /// Cell height
    var cellHeight: CGFloat
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String
    
    /// Is selected
    var isSelected: Bool
    
    /// Item data index
    var itemDataIndex: Int
    
    /// Details attributed string
    var detailsAttributedString: NSAttributedString
    
    /**
     Initializer
     */
    init() {
        
        // Default values
        self.cellHeight = CurrencyPickerTableViewCell.getHeight()
        self.cellReuseIdentifier = CurrencyPickerTableViewCell.getReuseIdentifier()
        self.isSelected = false
        self.itemDataIndex = -1
        self.detailsAttributedString = NSAttributedString()
    }
    
    /**
     Initializer
     - Parameter currency: Currency
     - Parameter isSelected: Bool, to indicate if the passed currency is the selected one or not
     */
    convenience init(currency: Currency, isSelected: Bool) {
        self.init()
        
        // Set is selected
        self.isSelected = isSelected
        
        // Setup font, name and code foreground color
        var font = UIFont.systemFont(ofSize: 17.0)
        var nameForegroundColor = UIColor.black
        var codeForegroundColor = UIColor.gray
        
        // Check if this is the selected currency, and change to custom font and foreground color
        if isSelected {
            font = UIFont.boldSystemFont(ofSize: 20.0)
            nameForegroundColor = .blue
            codeForegroundColor = .blue
        }
        
        // Init mutable attributed string, and add the currency name with a new line
        let mutableAttributedString = NSMutableAttributedString(string: currency.name + "\n", attributes: [.font: font, .foregroundColor: nameForegroundColor])
        
        // Append to mutable attributed string, and add the currency code
        mutableAttributedString.append(NSAttributedString(string: currency.code, attributes: [.font: font, .foregroundColor: codeForegroundColor]))
        
        // Set details attributed string
        self.detailsAttributedString = mutableAttributedString
    }
    
    /**
     Search
     - Parameter text: String
     - Returns: Bool, to indicate that this representable must be included in the filtered list, and one of the needed values
     */
    func search(text: String) -> Bool {
        
        // Here we lowercased all the string content and search if the content contains some of the passed characters
        return self.detailsAttributedString.string.lowercased().contains(text.lowercased())
    }
}
