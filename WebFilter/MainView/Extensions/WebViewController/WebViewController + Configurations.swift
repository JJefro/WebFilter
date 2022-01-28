//
//  WebViewController + Configurations.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 24/01/2022.
//

import Foundation
import SnapKit

extension WebViewController {

    func addViews() {
        addNavigationView()
        addWebView()
    }

    func bind() {
        navigationView.delegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        model.delegate = self

        addTargetsToNavigationButtons()
    }

    private func addTargetsToNavigationButtons() {
        navigationView.returnButton.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
        navigationView.forwardButton.addTarget(self, action: #selector(forwardButtonTapped(_:)), for: .touchUpInside)
        navigationView.addFilterButton.addTarget(self, action: #selector(addFilterButtonTapped(_:)), for: .touchUpInside)
        navigationView.showCurrentFiltersButton.addTarget(self, action: #selector(showCurrentFiltersButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func addNavigationView() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(110)
        }
    }

    private func addWebView() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(navigationView.snp.top)
        }
    }
}
