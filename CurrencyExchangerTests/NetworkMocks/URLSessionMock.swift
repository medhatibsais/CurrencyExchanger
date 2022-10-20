//
//  URLSessionMock.swift
//  CurrencyExchangerTests
//
//  Created by Medhat Ibsais on 19/10/2022.
//

import Foundation

class URLSessionMock: URLSessionProtocol {
    
    var testData: Data?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        defer {
            completionHandler(testData, nil, nil)
        }
        
        return DataTaskMock()
    }
}
