//
//  URLSessionProtocol.swift
//  CurrencyExchangerTests
//
//  Created by Medhat Ibsais on 19/10/2022.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
