//
//  ExchangeInfoCollectionViewCell.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Exchange Info Collection View Cell
class ExchangeInfoCollectionViewCell: UICollectionViewCell {

    /// Container view
    @IBOutlet private weak var containerView: UIView!
    
    /// Info label
    @IBOutlet private weak var infoLabel: UILabel!
    
    /**
     Awake from nib
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set number of lines to zero, to make the label multiple lines
        self.infoLabel.numberOfLines = 0
        
        // Setup container view
        self.containerView.backgroundColor = .white
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor.black.cgColor
        self.containerView.layer.cornerRadius = 5
        self.containerView.clipsToBounds = true
    }
    
    /**
     Setup
     - Parameter representable: Exchange Info Collection View Cell Representable
     */
    func setup(with representable: ExchangeInfoCollectionViewCellRepresentable) {
        
        // Set info label attributed text
        self.infoLabel.attributedText = representable.infoAttributedString
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
     - Parameter collectionView: UICollectionView
     */
    class func register(in collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: String(describing: self), bundle: Bundle.main), forCellWithReuseIdentifier: Self.getReuseIdentifier())
    }
    
    /**
     Get size
     - Returns: CGSize, the width and height for the cell
     */
    class func getSize() -> CGSize {
        return CGSize(width: 130.0, height: 130.0)
    }
}
