//
//  UIViewController+Exts.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

extension UIViewController {
    func pushViewController<T: UIViewController>(_ viewController: T) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
