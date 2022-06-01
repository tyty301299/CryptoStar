//
//  OTPTextField.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 22/05/2022.
//

import UIKit
class OTPTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?

    override func deleteBackward() {
        text = ""
        previousTextField?.becomeFirstResponder()
    }
}
