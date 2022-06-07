//
//  UIButton.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 23/05/2022.
//

import UIKit

extension UIButton {
    func setFontButton(title: TitleNavigationBar, textColor: UIColor) {
        let text = NSMutableAttributedString(string: title.rawValue)
        text.addAttributes([.font: UIFont.sfProDisplay(font: .medium, size: 16.scaleW), .foregroundColor: textColor], range: NSRange(location: 0, length: text.length))
        setAttributedTitle(text, for: .normal)
    }

    func setUpButton(text: TitleNavigationBar, background: UIColor, textColor: UIColor) {
        setFontButton(title: text, textColor: textColor)
        setCornerRadius(cornerRadius: 10)
        backgroundColor = background
        setFontButton(title: text, textColor: textColor)
    }

    func setFontButton(text: String, textColor: UIColor, size: Double, font: Font) {
        let text = NSMutableAttributedString(string: text)
        text.addAttributes([.font: UIFont.sfProDisplay(font: Font.regular, size: size.scaleW), .foregroundColor: textColor], range: NSRange(location: 0, length: text.length))
        setAttributedTitle(text, for: .normal)
    }

}
