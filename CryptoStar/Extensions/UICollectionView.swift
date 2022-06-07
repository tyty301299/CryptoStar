//
//  UICollectionView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 05/06/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(aClass: T.Type) {
        let className = String(describing: aClass)
        register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }

    func dequeueCell<T: UICollectionViewCell>(aClass: T.Type, indexPath: IndexPath) -> T {
        let className = String(describing: aClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
}
