//
//  FormattedURL.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 26/01/2022.
//

import Foundation

struct FormattedURL {

    init(string: String) {
        self.string = string
    }
    
    var string: String
    
    var url: URL? {
        var value = string
        if !value.lowercased().hasPrefix("https://") {
            value.insert(contentsOf: "https://", at: value.startIndex)
        }
        return URL(string: value)
    }
}
