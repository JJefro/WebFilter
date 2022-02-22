//
//  FiltersListTableView.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 21/02/2022.
//

import UIKit

class FiltersListTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FiltersListTableView {
    func configure() {
        register(FiltersListTableViewCell.self, forCellReuseIdentifier: FiltersListTableViewCell.identifier)
        rowHeight = 50

        separatorStyle = .singleLine
        separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        separatorColor = .lightGray

        backgroundColor = .clear
    }
}
