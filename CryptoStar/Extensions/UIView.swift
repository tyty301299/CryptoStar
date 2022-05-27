//
//  Layer.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import UIKit

extension UIView {
    func setCornerRadius(cornerRadius: Double) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius.scaleW
    }
}
