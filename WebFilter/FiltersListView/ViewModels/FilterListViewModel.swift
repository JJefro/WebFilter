//
//  FilterListViewModel.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 24/02/2022.
//

import Foundation

class FilterListViewModel {
    func isValidFilter(filter: Filter) -> Bool {
        return !filter.rawValue.contains(" ") && filter.rawValue.count > 2
    }
}
