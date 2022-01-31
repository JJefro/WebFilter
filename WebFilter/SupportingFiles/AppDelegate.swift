//
//  AppDelegate.swift
//  WebFilter
//
//  Created by Jevgenijs Jefrosinins on 22/01/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        if #available(iOS 13, *) { } else {
            let navController = UINavigationController(rootViewController: WebViewController())

            let barAppearance = UINavigationBar.appearance()
            barAppearance.backgroundColor = UIColor.clear
            barAppearance.titleTextAttributes = [NSAttributedString.Key.font: R.font.sfProDisplayBold(size: 17)!]

            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navController
            window.makeKeyAndVisible()
            self.window = window
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
