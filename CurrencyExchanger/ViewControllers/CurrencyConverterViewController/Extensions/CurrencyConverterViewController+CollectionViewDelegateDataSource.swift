//
//  CurrencyConverterViewController+CollectionViewDelegateDataSource.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import Foundation
import UIKit

// MARK: - Collection View Data Source
extension CurrencyConverterViewController: UICollectionViewDataSource {
    
    /**
     Number of items in section
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(in: section)
    }
    
    /**
     Cell for item
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get exchange info collection view cell representable
        if let representable = self.viewModel.representableForItem(at: indexPath) as? ExchangeInfoCollectionViewCellRepresentable {
            
            // Dequeue cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: representable.cellReuseIdentifier, for: indexPath) as! ExchangeInfoCollectionViewCell
            
            // Setup cell
            cell.setup(with: representable)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
