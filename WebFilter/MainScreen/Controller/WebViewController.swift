//
//  ViewController.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 22/01/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    var navigationView = NavigationView()
    var model = WebViewModel(localDataSource: LocalDataSource())
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        addViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        loadInitialURL()
        setAccessibilityIdentifiers()
    }
    
    private func loadInitialURL() {
        let googleComponents = model.googleURLComponents
        guard let url = FormattedURL(string: googleComponents.host!).url else { return }
        webView.load(URLRequest(url: url))
    }
    
    @objc func returnButtonTapped(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func forwardButtonTapped(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc func addFilterButtonTapped(_ sender: UIButton) {
        presentAddFilterAlert()
    }
    
    @objc func showCurrentFiltersButtonTapped(_ sender: UIButton) {
        model.onOpenFiltersListView?(model.filters)
    }
}

// MARK: - WebViewController Configurations
private extension WebViewController {
    func addViews() {
        addNavigationView()
        addWebView()
    }

    func bind() {
        navigationView.delegate = self
        webView.navigationDelegate = self
        model.delegate = self

        addKeyboardHideOnTappedAroundRecognizer()
        addTargetsToNavigationButtons()
    }

    func addTargetsToNavigationButtons() {
        navigationView.returnButton.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
        navigationView.forwardButton.addTarget(self, action: #selector(forwardButtonTapped(_:)), for: .touchUpInside)
        navigationView.addFilterButton.addTarget(self, action: #selector(addFilterButtonTapped(_:)), for: .touchUpInside)
        navigationView.showCurrentFiltersButton.addTarget(self, action: #selector(showCurrentFiltersButtonTapped(_:)), for: .touchUpInside)
    }

    func addNavigationView() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
        }
    }

    func addWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(navigationView.snp.top)
        }
    }
}

// MARK: - WebViewController Alerts
private extension WebViewController {
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
            if self.model.isValidFilter(filter: filter) {
            self.model.filters.append(Filter(rawValue: text))
            }
        }
        let cancelButton = UIAlertAction(title: R.string.localizable.mainView_addFilterAlert_cancelButton_title(),
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(addFilterButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }

    func showErrorAlert(withTitle title: String?, withMessage message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.mainView_errorAlert_cancelButton_title(),
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - NavigationView Delegate Methods
extension WebViewController: NavigationViewDelegate {
    func navigationView(_ navigationView: NavigationView, textFieldEditingDidEnd text: String) {
        model.performValidationURL(text: text)
    }
}

// MARK: - WKNavigation Delegate Methods
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        navigationItem.title = url.host
        navigationView.textfieldText = url.absoluteString
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(model.isForbidden(urlResponse: navigationResponse.response))
    }
}

// MARK: - WebViewModel Delegate Methods
extension WebViewController: WebViewModelDelegate {
    func webViewModel(_ webViewModel: WebViewModel, didAnAttemptToGetInForbiddenLink filter: Filter) {
        showErrorAlert(withTitle: "Forbidden", withMessage: "By filter - " + filter.rawValue)
    }

    func webViewModel(_ webViewModel: WebViewModel, didUpdate urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}

// MARK: - FiltersListViewController Delegate Methods
extension WebViewController: FiltersListViewControllerDelegate {
    func filtersListViewController(_ filtersListViewController: FiltersListViewController, didUpdateFiltersList filters: [Filter]) {
        model.filters = filters
    }
}

// MARK: - WebViewController AccessibilityIdentifiers
private extension WebViewController {
    func setAccessibilityIdentifiers() {
        navigationController?.navigationBar.accessibilityIdentifier = WebViewAccessibilityID.navigationBar
        view.accessibilityIdentifier = WebViewAccessibilityID.mainScreen

        navigationView.accessibilityIdentifier = WebViewAccessibilityID.navigationView

        navigationView.textFieldView.txtField.accessibilityIdentifier = WebViewAccessibilityID.NavigationView.searchTectField
        navigationView.returnButton.accessibilityIdentifier = WebViewAccessibilityID.NavigationView.returnButton
        navigationView.forwardButton.accessibilityIdentifier = WebViewAccessibilityID.NavigationView.forwardButton
        navigationView.addFilterButton.accessibilityIdentifier = WebViewAccessibilityID.NavigationView.addFilterButton
        navigationView.showCurrentFiltersButton.accessibilityIdentifier = WebViewAccessibilityID.NavigationView.showFilterListButton
    }
}
