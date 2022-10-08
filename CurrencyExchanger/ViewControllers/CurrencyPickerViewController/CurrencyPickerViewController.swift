//
//  CurrencyPickerViewController.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Currency Picker View Controller
class CurrencyPickerViewController: BaseViewController {
    
    /// Table view
    @IBOutlet private(set) weak var tableView: UITableView!
    
    /// Table view bottom constraint
    @IBOutlet private weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    /// Search bar
    @IBOutlet private weak var searchBar: UISearchBar!
    
    /// Selected currency
    var selectedCurrency: Currency!
    
    /// Delegate
    weak var delegate: CurrencyPickerViewControllerDelegate?
    
    /// View model
    private(set) var viewModel: CurrencyPickerViewModel!
    
    /**
     View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init view model
        self.viewModel = CurrencyPickerViewModel(selectedCurrency: self.selectedCurrency)
        
        // Set main view background color to white
        self.view.backgroundColor = .white
        
        // Setup table view
        self.setupTableView()
        
        // Setup search bar
        self.setupSearchBar()
    }
    
    /**
     View will appear
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Register for keyboard notifications
        self.registerForKeyboardNotifications()
    }
    
    /**
     View will disappear
     */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Unregister for keyboard notifications
        self.unregisterForKeyboardNotifications()
    }
    
    // MARK: - Setups
    
    /**
     Setup table view
     */
    private func setupTableView() {
        
        // Setup table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        
        // Register cell
        CurrencyPickerTableViewCell.register(in: self.tableView)
    }
    
    /**
     Setup search bar
     */
    private func setupSearchBar() {
        
        // Setup search bar
        self.searchBar.delegate = self
        self.searchBar.backgroundColor = .white
        self.searchBar.searchTextField.backgroundColor = .white
        self.searchBar.searchTextField.textColor = .black
        self.searchBar.searchTextField.becomeFirstResponder()
        self.searchBar.placeholder = NSLocalizedString("currencyPickerViewController.searchBar.placeholder", comment: "")
    }
    
    // MARK: - Keyboard Notifications
    
    /**
     Register this view controller to receive keyboard notifications
     */
    private func registerForKeyboardNotifications() {
        
        // Add observers to detect when the keyboard opens and closed
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /**
     Unregister this view controller for keyboard notifications
     */
    private func unregisterForKeyboardNotifications(){
        
        // Remove the observers on keyboard
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /**
     Keyboard will show
     - Parameter notification: The notification object
     */
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        guard let info = notification.userInfo , let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue , let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        // Get keyboard frame
        let keyboardFrame = keyboardFrameValue.cgRectValue
        
        // Get Space between safe area and superview
        let spaceBetweenSafeAreaAndSuperView: CGFloat = self.view.safeAreaInsets.bottom
        
        // Update constraints
        self.tableViewBottomConstraint.constant = (keyboardFrame.size.height - spaceBetweenSafeAreaAndSuperView)
        
        // Animate change in height
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    /**
     Keyboard will hide
     - Parameter notification: The notification object
     */
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        guard let info = notification.userInfo , let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        // Update constraints
        self.tableViewBottomConstraint.constant = 0
        
        // Animate change in height
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - Currency Picker View Controller Delegate

/// Currency Picker View Controller Delegate
protocol CurrencyPickerViewControllerDelegate: NSObjectProtocol {
    
    /**
     Did select item
     - Parameter item: Currency, the selected currency from the picker
     */
    func currencyPickerViewController(didSelectItem item: Currency)
}
