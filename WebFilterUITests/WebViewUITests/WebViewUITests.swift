//
//  WebFilterUITests.swift
//  WebFilterUITests
//
//  Created by Jevgenijs Jefrosinins on 31/01/2022.
//

import XCTest

class WebViewUITests: XCTestCase {

    let accessibility = WebViewAccessibilityID()
    
    var app: XCUIApplication!
    var navigationBar: XCUIElement!
    var navigationView: XCUIElement!

    var searchTectField: XCUIElement!
    var returnButton: XCUIElement!
    var forwardButton: XCUIElement!
    var addFilterButton: XCUIElement!
    var showFilterListButton: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()

        navigationBar = app.navigationBars[accessibility.navigationBar]
        navigationView = app.otherElements[accessibility.navigationView]

        searchTectField = navigationView.textFields[accessibility.searchTectField]
        returnButton = navigationView.buttons[accessibility.returnButton]
        forwardButton = navigationView.buttons[accessibility.forwardButton]
        addFilterButton = navigationView.buttons[accessibility.addFilterButton]
        showFilterListButton = navigationView.buttons[accessibility.showFilterListButton]
    }

    override func tearDownWithError() throws {
        app = nil

        navigationBar = nil
        navigationView = nil

        returnButton = nil
        forwardButton = nil
        addFilterButton = nil
        showFilterListButton = nil
    }

    func test_webView_presenceOfElements() throws {
        XCTAssertTrue(app.isOnWebView)

        XCTAssertTrue(navigationBar.exists)
        XCTAssertTrue(navigationView.exists)

        XCTAssertTrue(searchTectField.exists)
        XCTAssertTrue(returnButton.exists)
        XCTAssertTrue(forwardButton.exists)
        XCTAssertTrue(addFilterButton.exists)
        XCTAssertTrue(showFilterListButton.exists)
    }
}
