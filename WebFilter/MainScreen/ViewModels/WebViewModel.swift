//
//  WebViewModel.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 24/01/2022.
//

import UIKit
import WebKit

protocol WebViewModelProtocol {
    var delegate: WebViewModelDelegate? { get set }
    var filters: [Filter] { get set }
    var googleURLComponents: URLComponents { get }

    func performValidationURL(text: String)
}

protocol WebViewModelDelegate: AnyObject {
    func webViewModel(_ webViewModel: WebViewModel, didUpdate urlRequest: URLRequest)
    func webViewModel(_ webViewModel: WebViewModel, didAnAttemptToGetInForbiddenLink filter: Filter)
}

class WebViewModel: WebViewModelProtocol {

    weak var delegate: WebViewModelDelegate?
    var onOpenFiltersListView: (([Filter]) -> Void)?
    var filters: [Filter] = [] {
        didSet {
            localDataSource.storedFilters = filters
        }
    }

    var googleURLComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "google.com"
        urlComponents.path = "/search"
        return urlComponents
    }()

    private var localDataSource: LocalDataSourceProtocol

    init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
        loadFilters()
    }

    func performValidationURL(text: String) {
        let urlRegex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        if !urlTest.evaluate(with: text) {
            performGoogleSearch(text: text)
        } else {
            if let url = FormattedURL(string: text).url {
                delegate?.webViewModel(self, didUpdate: URLRequest(url: url))
            } else {
                performGoogleSearch(text: text)
            }
        }
    }

    func isValidFilter(filter: Filter) -> Bool {
        return !filter.rawValue.contains(" ") && filter.rawValue.count > 2
    }

    func isForbidden(urlResponse: URLResponse) -> WKNavigationResponsePolicy {
        guard let urlString = urlResponse.url?.absoluteString else { return .cancel }
        guard filters.contains(where: { urlString.contains($0.rawValue) }),
              let filter = filters.first(where: { urlString.contains($0.rawValue) }) else { return .allow }
        delegate?.webViewModel(self, didAnAttemptToGetInForbiddenLink: filter)
        return .cancel
    }

    private func performGoogleSearch(text: String) {
        var components = googleURLComponents
        components.queryItems = [URLQueryItem(name: "query", value: text)]
        guard let url = components.url else { return }
        delegate?.webViewModel(self, didUpdate: URLRequest(url: url))
    }

    private func loadFilters() {
        guard let localFilters = localDataSource.storedFilters else { return }
        filters = localFilters
    }
}
