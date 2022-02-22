//
//  ReusableViewProtocol.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 21/02/2022.
//

import Foundation

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
