//
// WebViewAccessibilityID.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 24/02/2022.
//

import Foundation

struct WebViewAccessibilityID {

    static let mainScreen = "mainScreen"
    static let navigationBar = "mainScreen_navBar"
    static let navigationView = "mainScreen_navigationView"

    struct NavigationView {
        static let searchTectField = "navigationView_textField"
        static let returnButton = "navigationView_returnButton"
        static let forwardButton = "navigationView_forwardButton"
        static let addFilterButton = "navigationView_addFilterButton"
        static let showFilterListButton = "navigationView_showFilterListButton"
    }
}
