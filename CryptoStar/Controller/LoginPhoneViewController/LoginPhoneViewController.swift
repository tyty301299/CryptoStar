//
//  LoginPhoneViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class LoginPhoneViewController: BaseViewController {
    @IBOutlet private var sendOTPButton: UIButton!
    @IBOutlet private var phoneNumberView: DataInputView!
    @IBOutlet private var navigationBarView: CustomNavigationBarView!

    @IBOutlet private var topPhoneViewLC: NSLayoutConstraint!
    @IBOutlet private var bottomSendOTPButtonLC: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: .loginPhone)
    }

    func setupViews() {
        phoneNumberView.dataInputTextField.delegate = self
        phoneNumberView.setupTextLabel(text: .phoneNumber)
        phoneNumberView.setupTextField(keyboardType: .numberPad)

        sendOTPButton.setUpButton(text: .otp, background: .black, textColor: .white)
        sendOTPButton.addTarget(self, action: #selector(actionSendNumberPhone), for: .touchUpInside)

        topPhoneViewLC.constant = 237.scaleH
        bottomSendOTPButtonLC.constant = 20.scaleH
    }

    @objc func actionSendNumberPhone() {
        if let numberPhoneText = phoneNumberView.dataInputTextField.text, numberPhoneText.isNotEmpty {
            var numberPhone = numberPhoneText
            if numberPhone[numberPhone.startIndex] == "0" {
                numberPhone.remove(at: numberPhone.startIndex)
            }
            var number = "+84\(numberPhone)"

            AuthManager.shared.startAuth(phoneNumber: number.removingLeadingSpaces()) { [weak self] (result: ClosureResult<String>) in
                guard let self = self else {
                    return
                }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        let verifyPhoneNumerViewController = VerifyPhoneNumberViewController()
                        verifyPhoneNumerViewController.numberphone = number.removingLeadingSpaces()
                        self.pushViewController(verifyPhoneNumerViewController)
                    }
                    break
                case let .failure(error):
                    self.showAlert(title: .errorTextField, message: error.localizedDescription)
                }
            }
        }
    }
}

extension LoginPhoneViewController: UITextFieldDelegate {
    // MARK: LIMIT SIZE TEXTFIELD

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "XXXX XXX XXXX", phone: newString)
        return false
    }

    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
