//
//  UITableView + Extensions.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 21/02/2022.
//

import UIKit

extension UITableViewCell: ReusableViewProtocol {}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable cell")
        }
        return cell
    }
}
