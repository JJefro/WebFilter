//
//  WebFilterUITests + Extensions.swift
//  WebFilterUITests
//
//  Created by Jevgenijs Jefrosinins on 24/02/2022.
//

import XCTest

extension XCUIApplication {

    var isOnWebView: Bool {
        return otherElements["mainScreen"].exists
    }
    var isOnFiltersListView: Bool {
        return otherElements["filtersView"].exists
    }
}
