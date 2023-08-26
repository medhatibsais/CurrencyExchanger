//
//  CurrencyPickerViewController+TableViewDelegateDataSource.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Compoenent Values
private struct ComponentValues {
    static let estimatedHeightForRow: CGFloat = 50.0
}

// MARK: - Table View Data Source
extension CurrencyPickerViewController: UITableViewDataSource {
    
    /**
     Number of rows in section
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(in: section)
    }
    
    /**
     Cell for row
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get currency picker table view cell representable
        if let representable = self.viewModel.representableForRow(at: indexPath) as? CurrencyPickerTableViewCellRepresentable {
            
            // Dequeue cell
            let cell = tableView.dequeueReusableCell(withIdentifier: representable.cellReuseIdentifier, for: indexPath) as! CurrencyPickerTableViewCell
            
            // Setup cell
            cell.setup(with: representable)
            
            // Set accessibility identifier
            cell.accessibilityIdentifier = representable.selectorType
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - Table View Delegate
extension CurrencyPickerViewController: UITableViewDelegate {
    
    /**
     Height for row
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow(at: indexPath)
    }
    
    /**
     Estimated height for row
     */
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return ComponentValues.estimatedHeightForRow
    }
    
    /**
     Did select row
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get currency
        if let currency = self.viewModel.getCurrency(at: indexPath) {
            
            // Call delegate
            self.delegate?.currencyPickerViewController(didSelectItem: currency)
            
            // Dismiss the picker
            self.dismiss(animated: true, completion: nil)
        }
    }
}
