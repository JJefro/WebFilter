//
//  FiltersListTableViewDataSource.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 21/02/2022.
//

import UIKit

protocol FiltersListTableViewDataSourceDelegate: AnyObject {
    func filtersListTableViewDataSource(_ filtersListTableViewDataSource: FiltersListTableViewDataSource, didRemoveFilter filter: Filter)
}

class FiltersListTableViewDataSource: NSObject, UITableViewDelegate {

    weak var delegate: FiltersListTableViewDataSourceDelegate?
    var filters: [Filter] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filters.count
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let filter = filters[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self = self else { return }
            self.delegate?.filtersListTableViewDataSource(self, didRemoveFilter: filter)
            completion(true)
        }
        delete.image = R.image.trashImage()
        delete.backgroundColor = R.color.filtersListView.backgroundColor()
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension FiltersListTableViewDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FiltersListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let filter = filters[indexPath.row]
        cell.updateCell(filter: filter)
        return cell
    }
}
