//
//  CurrencyCachingManager.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import Foundation

/// Component Values
private struct ComponentValues {
    static let thresholdTimeToRequestData: TimeInterval = 30*60
}

/// Currency Caching Manager
class CurrencyCachingManager {
    
    /// Notifications
    enum Notifications: String {
        case didLoadRates
    }
    
    /// Shared
    static let shared: CurrencyCachingManager = CurrencyCachingManager()
    
    /// Currencies
    private var currencies: [Currency]
    
    /// Last updated
    private var lastUpdated: TimeInterval
    
    /// Queue, for managing data reading and writing
    private var queue: DispatchQueue = DispatchQueue(label: "CurrencyCachingManager", attributes: .concurrent)
    
    /**
     Initializer
     */
    private init() {
        
        // Get currencies from the cache
        self.currencies = CachingUtil.getCurrencies()
        
        // Set the last updated to the max
        self.lastUpdated = TimeInterval(Int.max)
        
        // Schedule a timer to load the currency rates every 30 minutes
        Timer.scheduledTimer(withTimeInterval: ComponentValues.thresholdTimeToRequestData, repeats: true) { _ in
            self.loadCurrencyRates(baseCurrency: SystemUtils.baseCurrency, symbols: self.currencies.map({ $0.code })) { _ in
                
            }
        }
    }
    
    // MARK: - Getters
    
    /**
     Get currencies
     - Returns: List of currencies
     */
    func getCurrencies() -> [Currency] {
        
        // Currencies list
        var currenciesList: [Currency] = []
        
        // Set currencies list using synced queue
        self.queue.sync {
            currenciesList = self.currencies
        }
        
        return currenciesList
    }
    
    /**
     Get currency
     - Parameter code: String
     - Returns: Optional currency
     */
    func getCurrency(for code: String) -> Currency? {
        
        // Currency
        var currency: Currency?
        
        // Set currency using synced queue
        self.queue.sync {
            currency = self.currencies.first(where: { $0.code == code })
        }
        
        return currency
    }
    
    // MARK: - Setters
    
    /**
     Set currencies
     - Parameter currencies: List of currencies
     */
    private func setCurrencies(_ currencies: [Currency]) {
        
        // Set currencies using async queue
        self.queue.async {
            self.currencies = currencies
        }
    }
    
    // MARK: - Model
    
    /**
     Load currencies
     - Parameter completion: Completion block, return optional any, because we need only if it failed or succeeded
     */
    func loadCurrencies(completion: @escaping (Result<Any?, Error>) -> Void) {
        
        // Get currencies
        CurrencyExchangerModel.getCurrencies { result in
            
            // Check result
            switch result {
            case .success(let currencies):
                
                // Did load currencies
                self.didLoadCurrencies(currencies: currencies, completion: completion)
                
            case .failure(let error):
                
                // Call completion
                completion(.failure(error))
            }
        }
    }
    
    /**
     Get currency rates
     - Parameter baseCurrency: String
     - Parameter symbols: List of strings
     - Parameter completion: Completion block, return optional any, because we need only if it failed or succeeded
     */
    private func getCurrencyRates(baseCurrency: String = SystemUtils.baseCurrency, symbols: [String], completion: @escaping (Result<Any?, Error>) -> Void) {
        
        // Is cached currencies expired
        if self.isCachedCurrenciesExpired() {
            
            // Load currency rates
            self.loadCurrencyRates(baseCurrency: baseCurrency, symbols: symbols, completion: completion)
        }
        else {
            
            // Call completion, then the app will read it from the cache
            completion(.success(nil))
        }
    }
    
    /**
     Load currency rates
     - Parameter baseCurrency: String
     - Parameter symbols: List of strings
     - Parameter completion: Completion block, return optional any, because we need only if it failed or succeeded
     */
    private func loadCurrencyRates(baseCurrency: String, symbols: [String], completion: @escaping (Result<Any?, Error>) -> Void) {
        
        // Get currency rates
        CurrencyExchangerModel.getCurrencyRates(baseCurrency: baseCurrency, symbols: symbols) { result in
            
            // Check result
            switch result {
            case .success(let value):
                
                // Did load currency rates
                self.didLoadCurrencyRates(rates: value.rates, baseCurrency: value.baseCurrency)
                
                // Call completion
                completion(.success(nil))
                
            case .failure(let error):
                
                // Call completion
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Model result
    
    /**
     Did load currencies
     - Parameter currencies: List of currencies
     - Parameter completion: Completion block, return optional any, because we need only if it failed or succeeded
     */
    private func didLoadCurrencies(currencies: [Currency], completion: @escaping (Result<Any?, Error>) -> Void) {
        
        // Set currencies
        self.setCurrencies(currencies)
        
        // Get currency rates
        self.getCurrencyRates(symbols: currencies.map({ $0.code }), completion: completion)
    }
    
    /**
     Did load currency rates
     - Parameter rates: List of currency rates
     - Parameter baseCurrency: String
     */
    private func didLoadCurrencyRates(rates: [CurrencyRate], baseCurrency: String) {
        
        // Get currencies
        var currencies = self.getCurrencies()
        
        // Get index of base currency from the currencies list
        if let index = currencies.firstIndex(where: { $0.code == baseCurrency }) {
            
            // Set rates
            currencies[index].rates = rates
            
            // Set the updated currency with its rates
            self.setCurrencies(currencies)
            
            // Save currencies list in the cache
            CachingUtil.saveCurrencies(currencies: currencies)
            
            // Post a notification to indicate that new rates are loaded
            NotificationCenter.default.post(name: NSNotification.Name(Self.Notifications.didLoadRates.rawValue), object: nil)
        }
    }
    
    // MARK: - Cache expiration
    
    /**
     Is cached currencies expired
     - Returns: Bool, to indicate if the time passed and the cached data is expired to refresh it the data again
     */
    private func isCachedCurrenciesExpired() -> Bool {
        
        // Check if the wifi is turned on, and the time is passed
        if SystemUtils.isNetworkReachable, self.lastUpdated >= ComponentValues.thresholdTimeToRequestData {
            return true
        }
        
        return false
    }
}
