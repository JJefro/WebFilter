//
//  FiltersListViewUITests.swift
//  WebFilterUITests
//
//  Created by Jevgenijs Jefrosinins on 24/02/2022.
//

import XCTest

class FiltersListViewUITests: XCTestCase {

    let accessibility = FiltersListViewAccessibilityID()

    var app: XCUIApplication!
    var navigationBar: XCUIElement!

    var navigationView: XCUIElement!
    var showFilterListButton: XCUIElement!

    var navBarBackButton: XCUIElement!
    var tableView: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()

        navigationBar = app.navigationBars[accessibility.navigationBar]
        navigationView = app.otherElements[accessibility.navigationView]
        showFilterListButton = navigationView.buttons[accessibility.showFilterListButton]

        navBarBackButton = navigationBar.buttons.element(boundBy: 0)
        tableView = app.tables[accessibility.tableView]
    }

    override func tearDownWithError() throws {
        app = nil

        navigationBar = nil
        navigationView = nil
        showFilterListButton = nil

        navBarBackButton = nil
        tableView = nil
    }

    func test_webView_presenceOfElements() throws {
        XCTAssertTrue(app.isOnWebView)
        showFilterListButton.tap()
        XCTAssertTrue(navigationBar.exists)
        XCTAssertTrue(navigationView.exists)
        XCTAssertTrue(navBarBackButton.exists)
        XCTAssertTrue(tableView.exists)
    }
}
