//
//  AppDelegate.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import CoreData
import Firebase
import FirebaseAuth
import FirebaseCore
import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let email = UserDefaults.standard.value(forKey: "Email") as? String, let passWord = UserDefaults.standard.value(forKey: "Pass") as? String {
            setTabBarRootViewController()
        } else {
            setLoginRootViewController()
        }
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return userActivity.webpageURL.flatMap(handlePasswordlessSignIn)!
    }

    func handlePasswordlessSignIn(withURL url: URL) -> Bool {
        let link = url.absoluteString
        if Auth.auth().isSignIn(withEmailLink: link) {
            if let email = UserDefaults.standard.value(forKey: "Email") as? String, let passWord = UserDefaults.standard.value(forKey: "Pass") as? String {
                AuthManager.shared.signUpEmail(email: email, password: passWord.MD5) { result in
                    switch result {
                    case .success:
                        self.setTabBarRootViewController()
                    case let .failure(error):
                        fatalError(error.localizedDescription)
                    }
                }
            }
            return true
        }
        return false
    }
}

extension AppDelegate {
    func setLoginRootViewController() {
        let mainVC = WelcomeViewController()
        let nav = BaseNavigationController(rootViewController: mainVC)

        window?.rootViewController = nav
    }

    func setTabBarRootViewController() {
        window?.rootViewController = BaseTabBarController()
    }
}
