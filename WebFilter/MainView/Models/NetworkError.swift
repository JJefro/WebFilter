//
//  NetworkError.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 28/01/2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return R.string.localizable.networkError_badURL()
        }
    }
}
