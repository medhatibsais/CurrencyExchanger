//
//  CurrencyConverterViewController.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import UIKit

/// Currency Converter View Controller
class CurrencyConverterViewController: BaseViewController {

    /// Collection view
    @IBOutlet private weak var collectionView: UICollectionView!
    
    /// Amount text field
    @IBOutlet private weak var amountTextField: UITextField!
    
    /// Currency selection button
    @IBOutlet private weak var currencySelectionButton: UIButton!
    
    /// Force reload button
    @IBOutlet private weak var forceReloadButton: UIButton!
    
    /// Amount label
    @IBOutlet private weak var amountLabel: UILabel!
    
    /// View model
    private(set) var viewModel: CurrencyConverterViewModel!
    
    /// Selected currency
    var selectedCurrency: Currency?
    
    /**
     View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ProcessInfo.processInfo.environment["IS_TESTING"] == "1" {
            print("We're in test mode")
        } else {
            print("We're not in test mode")
        }
        
        // Init view model
        self.viewModel = CurrencyConverterViewModel()
        
        // Setup components
        self.setupAmountTextField()
        self.setupAmountLabel()
        self.setupCurrencyButton()
        self.setupCollectionView()
        self.setupForceReloadButton()
        
        // Register notifications
        self.registerNotifications()
        
        // Add tap gesture recognizer to the view, to hide the keyboard when the user clicks anything on the view
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.endViewEditing)))
        
        // Load data
        self.loadData()
    }
    
    // MARK: - Notifications
    
    /**
     Register notifications
     */
    private func registerNotifications() {
        
        // Observe loading rates notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotifications(_:)), name: NSNotification.Name(rawValue: CurrencyCachingManager.Notifications.didLoadRates.rawValue), object: nil)
    }
    
    /**
     Handle notifications
     - Parameter notification: NSNotification
     */
    @objc private func handleNotifications(_ notification: NSNotification) {
        
        // Check if the notification name is did load rates
        if notification.name.rawValue == CurrencyCachingManager.Notifications.didLoadRates.rawValue {
            
            // Did load data
            self.didLoadData()
            
            // Did change text field value
            self.didChangeTextFieldValue(self.amountTextField)
        }
    }
    
    // MARK: - Setups
    
    /**
     Setup amount text field
     */
    private func setupAmountTextField() {
        
        // Setup text field
        self.amountTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("currencyConverterViewController.amountTextField.placeholder", comment: ""), attributes: [.foregroundColor: UIColor.gray])
        self.amountTextField.keyboardType = .decimalPad
        self.amountTextField.backgroundColor = .white
        self.amountTextField.textColor = .black
        self.amountTextField.layer.borderColor = UIColor.black.cgColor
        self.amountTextField.layer.borderWidth = 2
        self.amountTextField.delegate = self
        self.amountTextField.addTarget(self, action: #selector(self.didChangeTextFieldValue(_:)), for: .editingChanged)
    }
    
    /**
     Setup force reload button
     */
    private func setupForceReloadButton() {
        
        // Set title
        self.forceReloadButton.setTitle(NSLocalizedString("currencyConverterViewController.forceReloadButton.title", comment: ""), for: .normal)
    }
    
    /**
     Setup amount label
     */
    private func setupAmountLabel() {
        
        // Set text color
        self.amountLabel.textColor = .white
        
        // Set text
        self.amountLabel.text = NSLocalizedString("currencyConverterViewController.amountLabel.placeholder", comment: "")
    }
    
    /**
     Setup currency button
     */
    private func setupCurrencyButton() {
        
        // Get the default currency
        if let firstCurrency = CurrencyCachingManager.shared.getCurrencies().first {
            
            // Set selected currency
            self.selectedCurrency = firstCurrency
            
            // Set title
            self.currencySelectionButton.setTitle(firstCurrency.code, for: .normal)
            
            // Set target
            self.currencySelectionButton.addTarget(self, action: #selector(self.openCurrencyPicker), for: .touchUpInside)
        }
        else {
            
            // Disable the button
            self.currencySelectionButton.isEnabled = false
        }
    }
    
    /**
     Setup collection view
     */
    private func setupCollectionView() {
        
        // Setup flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.itemSize = ExchangeInfoCollectionViewCell.getSize()
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // Set collection view layout
        self.collectionView.collectionViewLayout = flowLayout
        
        // Setup collection view
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .clear
        
        // Register cell
        ExchangeInfoCollectionViewCell.register(in: self.collectionView)
    }
    
    // MARK: - Actions
    
    /**
     Did change selected currency
     */
    func didChangeSelectedCurrency(selectedCurrency: Currency) {
        
        // Set selected currency
        self.selectedCurrency = selectedCurrency
        
        // Did change text field value
        self.didChangeTextFieldValue(self.amountTextField)
        
        // Set new button title
        self.currencySelectionButton.setTitle(self.selectedCurrency?.code ?? "", for: .normal)
        
        // Enable the button
        self.currencySelectionButton.isEnabled = true
    }
    
    /**
     Open currency picker
     */
    @objc func openCurrencyPicker() {
        
        // Create view controller
        let viewController = ViewControllerFactory.createViewController(type: .currencyPickerViewController) as! CurrencyPickerViewController
        
        // Set selected currency
        viewController.selectedCurrency = self.selectedCurrency
        
        // Set delegate
        viewController.delegate = self
        
        // Present view
        self.present(viewController, animated: true, completion: nil)
    }
    
    /**
     Did change text field value
     - Parameter textField: UITextField
     */
    @objc private func didChangeTextFieldValue(_ textField: UITextField) {
        
        // Get the text field value, convert it to double, and check selected currency is not nil
        if let value = textField.text, let amount = Double(value), let currency = self.selectedCurrency {
            
            // Set the exchange amount to the result label
            self.amountLabel.text = CurrencyConverter.exchange(amount: amount, to: currency.code)?.description
        }
        else {
            
            // Set the place holder in case of nothing in the text field
            self.amountLabel.text = NSLocalizedString("currencyConverterViewController.amountLabel.placeholder", comment: "")
        }
    }
    
    /**
     End view editing
     */
    @objc private func endViewEditing() {
        self.view.endEditing(true)
    }
    
    /**
     Force data reload
     */
    @IBAction private func forceDataReload(_ sender: Any) {
            
        // Load data
        self.loadData()
    }
    
    /**
     Scroll view did scroll
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // End view editing
        self.endViewEditing()
    }
    
    // MARK: - Model
    
    /**
     Load data
     */
    private func loadData() {
        
        // Show loading view
        self.showLoadingView(true)
        
        // Load currencies
        CurrencyCachingManager.shared.loadCurrencies { [weak self] result in

            // self
            guard let self = self else { return }
            
            // Check result
            switch result {
            case .success:
                
                // Did load data
                self.didLoadData()
                
            case .failure(let error):
                
                // Message
                var message = error.localizedDescription
                
                // Check if the error of type currency error
                if let error = error as? CurrencyError {
                    
                    // Get the error description
                    message = error.description
                }
                
                // Show alert view
                self.showAlertView(with: NSLocalizedString("alertView.title", comment: ""), and: message)
            }
            
            // Hide loading view
            self.showLoadingView(false)
        }
    }
    
    /**
     Did load data
     */
    private func didLoadData() {
        
        // Get currency
        if let currency = CurrencyCachingManager.shared.getCurrency(for: SystemUtils.baseCurrency) {
            
            // Set currency
            self.viewModel.setCurrency(currency)
            
            // Reload data
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Alert view
    
    /**
     Show alert view
     - Parameter title: String
     - Parameter message: String
     */
    private func showAlertView(with title: String, and message: String) {
        
        // Init alert view
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add action
        alertView.addAction(UIAlertAction(title: NSLocalizedString("alertView.actions.ok.title", comment: ""), style: .default, handler: nil))
        
        // Present alert view
        self.present(alertView, animated: true, completion: nil)
    }
}

