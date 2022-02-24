//
//  AppDelegate.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 22/01/2022.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let webViewController = WebViewController()
        let filtersListViewController = FiltersListViewController()
        let navController = UINavigationController(rootViewController: webViewController)

        if #available(iOS 13, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = R.color.navigationViewColors.backgroundColor()
            barAppearance.titleTextAttributes = [NSAttributedString.Key.font: R.font.sfProDisplayRegular(size: 15)!]
            navController.navigationBar.standardAppearance = barAppearance
            navController.navigationBar.scrollEdgeAppearance = barAppearance
        } else {
            let barAppearance = UINavigationBar.appearance()
            barAppearance.backgroundColor = R.color.navigationViewColors.backgroundColor()
            barAppearance.titleTextAttributes = [NSAttributedString.Key.font: R.font.sfProDisplayRegular(size: 15)!]
        }
        
        webViewController.model.onOpenFiltersListView = { filters in
            filtersListViewController.filters = filters
            filtersListViewController.delegate = webViewController
            navController.pushViewController(filtersListViewController, animated: true)
        }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
