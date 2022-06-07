//
//  UIViewController+Exts.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func pushViewController<T: UIViewController>(_ viewController: T) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Alert

extension UIViewController {
    func showAlert(title: DataTextField, message: String) {
        let alert = UIAlertController(title: title.getTitle(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
