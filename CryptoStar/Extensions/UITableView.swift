//
//  UITableView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(aClass: T.Type) {
        let className = String(describing: aClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }

    func dequeueCell<T: UITableViewCell>(aClass: T.Type, indexPath: IndexPath) -> T {
        let className = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
}
