//
//  LoginPhoneViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class LoginPhoneViewController: BaseViewController {
    @IBOutlet var navigationBarView: CustomNavigationBarView!
    @IBOutlet var topDataInputViewLC: NSLayoutConstraint!
    @IBOutlet var spaceBottomButtonLC: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!

    @IBOutlet var phoneNumberView: DataInputView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarView.setUpNavigationBarButton()
        navigationBarView.setUpStyleNavigaitonBarLabel()
        navigationBarView.titleLabel.setTitle(TitleNavigationBar.loginPhone)
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

        phoneNumberView.dataInputTextField.delegate = self
        phoneNumberView.setUpTextLabel(text: .phoneNumber)
        phoneNumberView.setUpTextField(keyboardType: .numberPad)

        sendButton.setUpButton(text: .otp, background: .black, textColor: .white)
        sendButton.addTarget(self, action: #selector(onClickSendButton), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topDataInputViewLC.constant = 237.scaleH
        spaceBottomButtonLC.constant = 20.scaleH
    }

    @objc func onClickSendButton() {
        if let text = phoneNumberView.dataInputTextField.text, !text.isEmpty {
            var numphone = text
            if numphone[numphone.startIndex] == "0" {
                numphone.remove(at: numphone.startIndex)
            }
            let number = "+84\(numphone)"

            AuthManager.shared.startAuth(phoneNumber: number) { [weak self] (result: ClosureResult<String>) in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        let veryPhoneVC = VerifyPhoneNumberViewController()
                        veryPhoneVC.phone = number
                        self?.pushViewController(veryPhoneVC)
                    }
                    break
                case let .failure(error):
                    print(error)
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
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 11
    }
}
