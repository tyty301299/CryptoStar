//
//  UIFont.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

extension UIFont {
    static func sfProDisplay(font: Font, size: Double) -> UIFont {
        return UIFont(name: font.rawValue, size: size.scaleW) ?? UIFont()
    }
}
