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
        print("Size Button : \(16.scaleW)")
    }
}
