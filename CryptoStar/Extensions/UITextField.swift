//
//  UITextField.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 10/06/2022.
//

import Foundation
import UIKit

extension UITextField {
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {
        leftViewMode = .always
        layer.masksToBounds = true

        switch padding {
        case let .left(spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            leftView = paddingView
            rightViewMode = .always

        case let .right(spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            rightView = paddingView
            rightViewMode = .always

        case let .both(spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            // left
            leftView = paddingView
            leftViewMode = .always
            // right
            rightView = paddingView
            rightViewMode = .always
        }
    }
}
