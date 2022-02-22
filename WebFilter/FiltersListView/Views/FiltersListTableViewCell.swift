//
//  FiltersListTableViewCell.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 21/02/2022.
//

import UIKit

class FiltersListTableViewCell: UITableViewCell {

    private let filterLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        addFilterLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCell(filter: Filter) {
        filterLabel.text = filter.rawValue
    }
}

private extension FiltersListTableViewCell {
    func configure() {
        backgroundColor = .clear
        selectionStyle = .none

        configureFilterLabel()
    }
    
    func configureFilterLabel() {
        filterLabel.font = R.font.sfProDisplayRegular(size: 15)
        filterLabel.textColor = R.color.textColor()
        filterLabel.numberOfLines = 0
        filterLabel.textAlignment = .left
    }

    func addFilterLabel() {
        addSubview(filterLabel)
        filterLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
