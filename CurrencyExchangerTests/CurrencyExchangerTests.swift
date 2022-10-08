//
//  CurrencyExchangerTests.swift
//  CurrencyExchangerTests
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import XCTest
@testable import CurrencyExchanger

class CurrencyExchangerTests: XCTestCase {

    override func setUp() {
    }
    
    override func tearDown() {

    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            CurrencyCachingManager.shared.loadCurrencies { _ in
                
            }
        }
    }

    func test2USDToAED() {
        
        var exchangeResult: Double = 0.0
        let convertedTo = "AED"
        let amount: Double = 2.0
        
        if let currency = CurrencyCachingManager.shared.getCurrency(for: SystemUtils.baseCurrency), let forigenCurrencyRate = currency.rates.first(where: { $0.code == convertedTo })?.amount {
        
            exchangeResult = amount * forigenCurrencyRate
        }
        
        XCTAssertEqual(CurrencyConverter.exchange(amount: amount, to: convertedTo), exchangeResult)
    }
    
    func test44USDToAED() {
        
        var exchangeResult: Double = 0.0
        let convertedTo = "AED"
        let amount: Double = 44.0
        
        if let currency = CurrencyCachingManager.shared.getCurrency(for: SystemUtils.baseCurrency), let forigenCurrencyRate = currency.rates.first(where: { $0.code == convertedTo })?.amount {
        
            exchangeResult = amount * forigenCurrencyRate
            
            
            let twoFractionValue = String(format: "%.2f", exchangeResult)
            
            exchangeResult = Double(twoFractionValue)!
        }
        
        if let value = CurrencyConverter.exchange(amount: amount, to: convertedTo) {
            
            // Assume the original value is "161.61419999999998" but we can set an accuracy value in order not to copy the whole fraction
            XCTAssertEqual(value, exchangeResult, accuracy: 0.01)
        }
    }
    
    func testGetCurrenciesAPI() {
        
        let expectation = XCTestExpectation(description: "Call currencies API")
        
        CurrencyExchangerModel.getCurrencies { result in
            
            switch result {
            case .success(let list):
                
                XCTAssertTrue(!list.isEmpty)
                
                expectation.fulfill()
                
            case .failure(let error):
                
                print(error.localizedDescription)
                XCTAssertTrue(error.localizedDescription.isEmpty)
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testCurrencyRatesAPI() {
        
        let expectation = XCTestExpectation(description: "Call rates API")
        
        CurrencyExchangerModel.getCurrencyRates(baseCurrency: "USD", symbols: ["AED"]) { result in
            
            switch result {
            case .success(let value):
                
                XCTAssertTrue(!value.rates.isEmpty)
                XCTAssertTrue(!value.baseCurrency.isEmpty)
                
                expectation.fulfill()
                
            case .failure(let error):
                
                XCTAssertTrue(error.localizedDescription.isEmpty)
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testRouter() {
        
    }
}
