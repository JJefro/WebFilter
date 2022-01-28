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
    var model = WebViewModel()

    override func loadView() {
        super.loadView()
        webView = WKWebView()
        addViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        loadInitialURL()
    }

    private func loadInitialURL() {
        let url = URL(string: "https://google.com")!
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

    }

    @objc func showCurrentFiltersButtonTapped(_ sender: UIButton) {
        
    }
}

extension WebViewController: NavigationViewDelegate {
    func navigationView(_ navigationView: NavigationView, textFieldEditingDidEnd text: String) {
        model.performValidationURL(text: text)
    }
}

extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.url?.host
        navigationView.textfieldText = webView.url!.absoluteString
    }
}

extension WebViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}

extension WebViewController: WebViewModelDelegate {
    func webViewModel(_ webViewModel: WebViewModel, didUpdate urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}
