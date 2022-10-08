//
//  ViewControllerFactory.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// View Controller Factory
class ViewControllerFactory {
    
    /// View Controllers Identifiers
    enum ViewControllersIdentifiers: String {
        case currencyConverterViewController    = "CurrencyConverterViewController"
        case currencyPickerViewController       = "CurrencyPickerViewController"
    }
    
    /// Storyboard Names
    enum StoryboardNames: String {
        case main = "Main"
    }
    
    /**
     Create view controller
     - Parameter type: View Controllers Identifiers
     - Returns: UIViewController
     */
    class func createViewController(type: ViewControllerFactory.ViewControllersIdentifiers) -> UIViewController {
        
        // Storyboard name
        var storyboardName: StoryboardNames = .main
        
        // Check type
        switch type {
        case .currencyConverterViewController, .currencyPickerViewController:
            storyboardName = .main
        }
        
        // Return view controller
        return UIStoryboard(name: storyboardName.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: type.rawValue)
    }
}
