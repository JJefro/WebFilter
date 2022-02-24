//
//  LocalDataSource.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 24/02/2022.
//

import Foundation

protocol LocalDataSourceProtocol {
    var storedFilters: [Filter]? { get set }
}

class LocalDataSource: LocalDataSourceProtocol {
    @CodableUserDefault(key: "com.jjefro.filters")
    var storedFilters: [Filter]?
}
