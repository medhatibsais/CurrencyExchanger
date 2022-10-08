//
//  CurrencyPickerTableViewCell.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Currency Picker Table View Cell
class CurrencyPickerTableViewCell: UITableViewCell {

    /// Details label
    @IBOutlet private weak var detailsLabel: UILabel!
    
    /**
     Awake from nib
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set selection style to none
        self.selectionStyle = .none
        
        // Set number of lines to zero, to make the label multiple lines
        self.detailsLabel.numberOfLines = 0
    }
    
    /**
     Setup
     - Parameter representable: Currency Picker Table View Cell Representable
     */
    func setup(with representable: CurrencyPickerTableViewCellRepresentable) {
        
        // Set details label attributed text
        self.detailsLabel.attributedText = representable.detailsAttributedString
    }
    
    // MARK: - Class methods
    
    /**
     Get reuse identifier
     - Returns: String, the cell identifier
     */
    class func getReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    /**
     Register
     - Parameter tableView: UITableView
     */
    class func register(in tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: Bundle.main), forCellReuseIdentifier: self.getReuseIdentifier())
    }
    
    /**
     Get height
     - Returns: CGFloat, the cell height, which is here is automatic to make the UIKit calculate the height
     */
    class func getHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
}
