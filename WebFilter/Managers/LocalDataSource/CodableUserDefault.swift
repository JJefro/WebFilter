//
//  CodableUserDefault.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 24/02/2022.
//

import Foundation

@propertyWrapper
struct CodableUserDefault<Value: Codable> {
    let key: String
    var defaultValue: Value?
    var container: UserDefaults = .standard

    var wrappedValue: Value? {
        get {
            guard let data = container.data(forKey: key) else {
                return nil
            }
            return try? JSONDecoder().decode(Value.self, from: data)
        }
        set {
            if let newValue = newValue, let data = try? JSONEncoder().encode(newValue) {
                container.set(data, forKey: key)
            } else {
                container.removeObject(forKey: key)
            }
        }
    }
}
