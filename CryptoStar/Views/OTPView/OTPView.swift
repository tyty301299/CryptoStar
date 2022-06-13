//
//  OTPView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 22/05/2022.
//

import UIKit

class OTPView: UIStackView {
    private var textFieldArray = [OTPTextField]()
    private var numberOfOTPdigit = 6
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setTextFields()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setTextFields()
    }

    private func setupStackView() {
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .center
        distribution = .fillEqually
        backgroundColor = .white
        spacing = 8.scaleW
    }

    var numTextField: String {
        var numberText = ""
        textFieldArray.forEach {
            numberText.append($0.text!)
        }
        return numberText
    }

    func becomeResponder() {
        textFieldArray.first?.becomeFirstResponder()
    }

    private func setTextFields() {
        for i in 0 ..< numberOfOTPdigit {
            let field = OTPTextField()
            field.tag = i
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            field.backgroundColor = .white
            field.keyboardType = .numberPad
            field.layer.opacity = 1
            field.textContentType = .oneTimeCode
            field.textAlignment = .center
            field.layer.borderWidth = 1
            field.layer.borderColor = UIColor.hexStringUIColor(color: .borderTextFieldColor).cgColor
            field.layer.cornerRadius = 5.scaleW
            field.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            i != 0 ? (field.previousTextField = textFieldArray[i - 1]) : ()
            i != 0 ? (textFieldArray[i - 1].nextTextFiled = textFieldArray[i]) : ()
        }
    }

    @objc private func textFieldDidChange(_ textField: OTPTextField) {
        let text = textField.text
    }
}

extension OTPView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string

            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            return true
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        guard let previousTextField = field.previousTextField else { return true }

        if previousTextField.text?.isEmpty == true { return false }
        return true
    }
}
