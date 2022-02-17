//
//  UIViewController + Extensions.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 13/02/2022.
//

import UIKit

extension UIViewController {
    func addKeyboardHideOnTappedAroundRecognizer(cancelsTouchesInView: Bool = true) {
        let endEditingTapRecognizer = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        endEditingTapRecognizer.cancelsTouchesInView = cancelsTouchesInView
        view.addGestureRecognizer(endEditingTapRecognizer)
    }
}
