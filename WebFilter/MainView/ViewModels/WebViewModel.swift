//
//  WebViewModel.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 24/01/2022.
//

import UIKit

protocol WebViewModelDelegate: AnyObject {
    func webViewModel(_ webViewModel: WebViewModel, didUpdate urlRequest: URLRequest)
}

class WebViewModel {

    weak var delegate: WebViewModelDelegate?

    var googleComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "google.com"
        urlComponents.path = "/search"
        return urlComponents
    }()

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
    
    private func performGoogleSearch(text: String) {
        var components = googleComponents
        components.queryItems = [URLQueryItem(name: "query", value: text)]
        guard let url = components.url else { return }
        delegate?.webViewModel(self, didUpdate: URLRequest(url: url))
    }
}
