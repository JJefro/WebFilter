//
//  MockLocalDataSource.swift
//  WebFilterTests
//
//  Created by Jevgenijs Jefrosinins on 24/02/2022.
//

import Foundation
@testable import WebFilter

class MockLocalDataSource: LocalDataSourceProtocol {
    @CodableUserDefault(key: "com.jjefro.filters.mocks")
    var storedFilters: [Filter]?
}
