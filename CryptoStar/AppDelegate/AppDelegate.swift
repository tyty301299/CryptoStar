//
//  AppDelegate.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import CoreData
import FirebaseCore
import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = WelcomeViewController()
        let nav = BaseNavigationController(rootViewController: mainVC)
        window?.rootViewController = nav
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }
}
