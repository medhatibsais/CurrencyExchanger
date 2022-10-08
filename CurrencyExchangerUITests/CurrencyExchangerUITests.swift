//
//  CurrencyExchangerUITests.swift
//  CurrencyExchangerUITests
//
//  Created by Medhat Ibsais on 09/09/2022.
//

import XCTest

class CurrencyExchangerUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddValue() {
        
        let amountTextField = app.textFields["Enter amount here"]
        amountTextField.tap()
        amountTextField.typeText("23")
        
        app.buttons["CurrencyButton"].tap()
        
        let textField = app.searchFields["Search for currency"]
        textField.tap()
        textField.typeText("aed")
        
        app.tables.cells.staticTexts["United Arab Emirates Dirham\nAED"].tap()
        
        app.buttons["Force Reload"].tap()
        
        amountTextField.tap()
        
        if let value = amountTextField.value as? String {
         
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: value.count)
            amountTextField.typeText(deleteString)
        }
        
        amountTextField.typeText("400")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
