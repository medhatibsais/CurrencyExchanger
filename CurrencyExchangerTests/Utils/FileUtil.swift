//
//  FileUtil.swift
//  CurrencyExchangerTests
//
//  Created by Medhat Ibsais on 19/10/2022.
//

import Foundation

class FileUtil {
    
    class func data(for filename: String) -> Data? {
        
//        let bundle = Bundle(for: type(of: self))
        
        let bundle = Bundle(for: self)
        
        guard let url = bundle.url(forResource: filename, withExtension: nil) else {
            return nil
        }
        
        return try? Data(contentsOf: url)
    }
}
