//
//  UILabel.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 22/05/2022.
//

import UIKit

extension UILabel {
    func setTitle<T: TitleProtocol>(_ title: T) {
        text = title.getTitle()
    }
}
