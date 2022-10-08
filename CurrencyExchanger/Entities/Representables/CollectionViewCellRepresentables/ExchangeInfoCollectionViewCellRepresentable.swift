//
//  ExchangeInfoCollectionViewCellRepresentable.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Exchange Info Collection View Cell Representable
class ExchangeInfoCollectionViewCellRepresentable: CollectionViewCellRepresentable {
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String
    
    /// Cell size
    var cellSize: CGSize
    
    /// Info attributed string
    var infoAttributedString: NSAttributedString
    
    /**
     Initializer
     */
    init() {
        
        // Default values
        self.cellReuseIdentifier = ExchangeInfoCollectionViewCell.getReuseIdentifier()
        self.cellSize = ExchangeInfoCollectionViewCell.getSize()
        self.infoAttributedString = NSAttributedString()
    }
    
    /**
     Initializer
     - Parameter baseCurrencyCode: String
     - Parameter rate: Currency Rate
     */
    convenience init(baseCurrencyCode: String, rate: CurrencyRate) {
        self.init()
        
        // Font
        let font = UIFont.systemFont(ofSize: 17.0)
        
        // Setup paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // Init mutable attributed string, and add the base currency
        let mutableAttributedString = NSMutableAttributedString(string: baseCurrencyCode + "\n", attributes: [.paragraphStyle: paragraphStyle, .font: font, .foregroundColor: UIColor.black])
        
        // Append to mutable attributed string, and add the second currency
        mutableAttributedString.append(NSAttributedString(string: rate.code + "\n", attributes: [.paragraphStyle: paragraphStyle, .font: font, .foregroundColor: UIColor.gray]))
        
        // Append to mutable attributed string, and add the conversion amount
        mutableAttributedString.append(NSAttributedString(string: rate.amount.description, attributes: [.paragraphStyle: paragraphStyle, .font: font, .foregroundColor: UIColor.red]))
        
        // Set info attributed string
        self.infoAttributedString = mutableAttributedString
    }
}
