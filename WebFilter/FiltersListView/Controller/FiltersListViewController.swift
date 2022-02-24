//
//  FiltersListViewController.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 19/02/2022.
//

import UIKit

protocol FiltersListViewControllerDelegate: AnyObject {
    func filtersListViewController(_ filtersListViewController: FiltersListViewController, didUpdateFiltersList filters: [Filter])
}

class FiltersListViewController: UIViewController {

    weak var delegate: FiltersListViewControllerDelegate?

    private var tableView = FiltersListTableView()
    private var dataSource = FiltersListTableViewDataSource()
    private var viewModel = FilterListViewModel()

    var filters: [Filter] = [] {
        didSet {
            delegate?.filtersListViewController(self, didUpdateFiltersList: filters)
            dataSource.filters = filters
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addViews()
        bind()
        setAccessibilityIdentifiers()
    }

    @objc func addButtonTapped() {
        presentAddFilterAlert()
    }
}

private extension FiltersListViewController {
    func configure() {
        view.backgroundColor = R.color.filtersListView.backgroundColor()
        navigationController?.navigationBar.topItem?.backButtonTitle = R.string.localizable.filtersListView_navBar_backButtonTitle()
        navigationController?.navigationBar.tintColor = R.color.textColor()
    }

    func addViews() {
        addTableView()
        addRightBarButton()
    }

    func bind() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        dataSource.delegate = self
    }

    func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
    }

    func addRightBarButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        rightBarButton.tintColor = R.color.textColor()
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

// MARK: - FiltersListViewController Alerts
private extension FiltersListViewController {
    func presentAddFilterAlert() {
        let alert = UIAlertController(title: R.string.localizable.mainView_addFilterAlert_title(),
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = R.string.localizable.mainView_addFilterAlert_placeholder()
            textField.returnKeyType = .done
        }
        let addFilterButton = UIAlertAction(title: R.string.localizable.mainView_addFilterAlert_addButton_title(),
                                            style: .default) { [weak self, weak alert] _ in
            guard let self = self, let alert = alert,
                  let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            let filter = Filter(rawValue: text)
            if self.viewModel.isValidFilter(filter: filter) {
                self.filters.append(filter)
            }
        }
        let cancelButton = UIAlertAction(title: R.string.localizable.mainView_addFilterAlert_cancelButton_title(),
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(addFilterButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - FiltersListTableViewDataSource Delegate Methods
extension FiltersListViewController: FiltersListTableViewDataSourceDelegate {
    func filtersListTableViewDataSource(_ filtersListTableViewDataSource: FiltersListTableViewDataSource, didRemoveFilter filter: Filter) {
        filters.removeAll(where: { $0 == filter })
    }
}

// MARK: - FiltersListViewController Accessibility Identifiers
private extension FiltersListViewController {
    func setAccessibilityIdentifiers() {
        view.accessibilityIdentifier = FiltersListViewAccessibilityID.filtersView
        tableView.accessibilityIdentifier = FiltersListViewAccessibilityID.tableView
    }
}
