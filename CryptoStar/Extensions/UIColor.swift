//
//  Extensions.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

extension UIColor {
    static func hexStringUIColor(color: Color) -> UIColor {
        return hexStringUIColor(hex: color.rawValue)
    }

    static func hexStringUIColor(hex: String) -> UIColor {
        let cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.count != 6 {
            return UIColor.gray
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    static func randomColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: Double.random(in: 0 ... 1),
                       green: Double.random(in: 0 ... 1),
                       blue: Double.random(in: 0 ... 1),
                       alpha: alpha)
    }
}
