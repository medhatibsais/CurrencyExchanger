//
//  SystemUtils.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import Alamofire

/// System Utils
class SystemUtils {
    
    /// App ID
    static let appID: String = "78d36a60c93d4016b57a6152abee87ac"
    
    /// Base currency
    static let baseCurrency: String = "USD"
    
    /// Default currency code
    static let defaultCurrencyCode: String = "JOD"
    
    /// Network reachability manager
    private static let networkReachabilityManager: NetworkReachabilityManager = NetworkReachabilityManager()!
    
    /// Is network reachable
    static var isNetworkReachable: Bool {
        return Self.networkReachabilityManager.isReachable
    }
    
    /**
     Response JSON serializer
     - Parameter data: Data
     - Returns: Dictionary of string and Any type
     */
    class func responseJSONSerializer(data: Data) -> [String: Any] {
        
        // Serialize JSON object
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed) as? [String: Any] else {
            return [:]
        }
        
        // Return the object
        return jsonObject
    }
}
