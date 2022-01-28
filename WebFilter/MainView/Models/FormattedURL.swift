//
//  FormattedURL.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 26/01/2022.
//

import Foundation

struct FormattedURL {
    var string: String

    init(string: String) {
        self.string = string
    }

    var url: URL? {
        var value = string
        if !value.lowercased().hasPrefix("https://") {
            value.insert(contentsOf: "https://", at: value.startIndex)
        }
        return URL(string: value)
    }
}
