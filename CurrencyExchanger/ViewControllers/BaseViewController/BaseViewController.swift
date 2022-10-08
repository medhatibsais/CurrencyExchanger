//
//  BaseViewController.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Base View Controller
class BaseViewController: UIViewController {
    
    /// Loading view
    var loadingView: UIView!
    
    /**
     View did load
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup loading view
        self.setupLoadingView()
    }
    
    /**
     Setup loading view
     */
    private func setupLoadingView() {
        
        // Setup loading view
        self.loadingView = UIView()
        self.loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add loading view
        self.view.addSubview(self.loadingView)
        
        // Setup constraints
        self.loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Setup loading indocator
        let loadingIdicator = UIActivityIndicatorView(style: .large)
        loadingIdicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIdicator.stopAnimating()
        loadingIdicator.color = .white
        
        // Add to view
        self.loadingView.addSubview(loadingIdicator)
        
        // Setup constraints
        loadingIdicator.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor).isActive = true
        loadingIdicator.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor).isActive = true
        
        // Hide the loading view initially
        self.loadingView.isHidden = true
    }
    
    /**
     Show loading view
     - Parameter show: Bool, boolean flag to know if we want to show it or hide it
     */
    func showLoadingView(_ show: Bool) {
        
        // Start/Stop loading indicator animation
        if let loadingIndicator = self.loadingView.subviews.first as? UIActivityIndicatorView {
            show ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        }
        
        // Show/Hide loading view
        self.loadingView.isHidden = !show
        self.view.bringSubviewToFront(self.loadingView)
    }
}
