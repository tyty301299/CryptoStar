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

    func roundCorners(corners: UIRectCorner, radius: Double) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius.scaleW, height: radius.scaleH))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func shadow(offset: CGSize, cornerRadius: Double) {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2
        layer.shadowPath = shadowPath.cgPath
        layer.backgroundColor = UIColor.clear.cgColor
    }
}
