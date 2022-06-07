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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topPhoneViewLC.constant = 237.scaleH
        bottomSendOTPButtonLC.constant = 20.scaleH
    }

    func setupViews() {
        phoneNumberView.dataInputTextField.delegate = self
        phoneNumberView.setUpTextLabel(text: .phoneNumber)
        phoneNumberView.setUpTextField(keyboardType: .numberPad)

        sendOTPButton.setUpButton(text: .otp, background: .black, textColor: .white)
        sendOTPButton.addTarget(self, action: #selector(actionSend), for: .touchUpInside)
    }

    @objc func actionSend() {
        if let text = phoneNumberView.dataInputTextField.text, text.isNotEmpty {
            var numberPhone = text
            if numberPhone[numberPhone.startIndex] == "0" {
                numberPhone.remove(at: numberPhone.startIndex)
            }
            let number = "+84\(numberPhone)"

            AuthManager.shared.startAuth(phoneNumber: number) { [weak self] (result: ClosureResult<String>) in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        let verifyPhoneVC = VerifyPhoneNumberViewController()
                        //TODO: Fix it
                        verifyPhoneVC.numberphone = number
                        self?.pushViewController(verifyPhoneVC)
                    }
                    break
                case let .failure(error):
                    self?.showAlert(title: .errorTextField, message: error.localizedDescription)
                }
            }
        }
    }
}

extension LoginPhoneViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let subStringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - subStringToReplace.count + string.count
        return count <= Limit.numberPhone
    }
}
