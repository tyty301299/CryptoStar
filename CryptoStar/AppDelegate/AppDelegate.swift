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

    static var shared: AppDelegate {
        return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configRootViewController()
        return true
    }

    func configRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = WelcomeViewController()
        let nav = BaseNavigationController(rootViewController: mainVC)
        window?.rootViewController = nav
        if Auth.auth().currentUser != nil {
            setTabBarViewController()
        } else {
            setWelcomeViewController()
        }

        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return userActivity.webpageURL.flatMap(handlePasswordlessSignIn) ?? false
    }

    func handlePasswordlessSignIn(withURL url: URL) -> Bool {
        let link = url.absoluteString
        if Auth.auth().isSignIn(withEmailLink: link) {
            let email = UserDefaultUtils.email
            let password = UserDefaultUtils.password
            if email.isNotEmpty,
               password.isNotEmpty {
                AuthManager.shared.signUpEmail(email: email, password: password.MD5) { [weak self] result in
                    switch result {
                    case .success:
                        self?.setTabBarViewController()
                    case let .failure(error):
                        // Crash app
                        self?.inputViewController?.showAlert(title: .errorTextField, message: error.localizedDescription)
                    }
                }
                return true
            }
        }
        return false
    }

    // MARK: - CORE DATA

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CryptoStar")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                self.inputViewController?.showAlert(title: .errorCoreData,
                                                    message: error.localizedDescription)
            }
        }
        return container
    }()

    // MARK: - CORE DATA SAVING

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                inputViewController?.showAlert(title: .errorCoreData,
                                               message: "\(error.userInfo)")
            }
        }
    }
}

extension AppDelegate {
    func setWelcomeViewController() {
        let mainVC = WelcomeViewController()
        let nav = BaseNavigationController(rootViewController: mainVC)

        window?.rootViewController = nav
    }

    func setTabBarViewController() {
        window?.rootViewController = BaseTabBarController()
    }
}
