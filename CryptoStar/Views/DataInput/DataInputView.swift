//
//  DataInputView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class DataInputView: BaseNibView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dataInputTextField: UITextField!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createLayerLineTextField()
    }

    func setUpTextLabel(text: TitleLabel) {
        titleLabel.text = text.rawValue
        titleLabel.font = .sfProDisplay(font: .regular, size: 10)
        titleLabel.textColor = UIColor.hexStringUIColor(color: .titleColorLabel)
    }

    func setUpTextField(keyboardType: UIKeyboardType, secureTextEntry: Bool = false) {
        dataInputTextField.keyboardType = keyboardType
        dataInputTextField.isSecureTextEntry = secureTextEntry
        dataInputTextField.font = .sfProDisplay(font: .regular, size: 18)
    }

    func createLayerLineTextField() {
        contentView.layer.sublayers?.filter { $0.name == "BottomLine" }.forEach { $0.removeFromSuperlayer() }
        let bottomLine = CALayer()
        bottomLine.name = "BottomLine"
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 0.5,
                                  width: bounds.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.hexStringUIColor(color: .titleColorLabel).cgColor
        contentView.layer.addSublayer(bottomLine)
    }
}
