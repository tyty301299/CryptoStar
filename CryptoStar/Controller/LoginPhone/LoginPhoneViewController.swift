//
//  LoginPhoneViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class LoginPhoneViewController: BaseViewController, UITextFieldDelegate {
    @IBOutlet var navigationBarView: CustomNavigationBarView!
    @IBOutlet var topLayoutDataInputView: NSLayoutConstraint!
    @IBOutlet var spaceBottomButton: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var phonenNumberView: DataInputView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarView.setUpButton()
        navigationBarView.setupStyleLabel()
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        navigationBarView.titleLabel.setTitle(title: TitleNavigationBar.loginPhone)
        phonenNumberView.dataInputTextField.delegate = self
        phonenNumberView.setUpTextLabel(text: .phoneNumber)
        phonenNumberView.setUpTextField()
        setupButton(customButton: sendButton, text: .otp, background: .black, textColor: .white)

        sendButton.addTarget(self, action: #selector(onClickSendButton), for: .touchDown)

//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topLayoutDataInputView.constant = 237.scaleH
        spaceBottomButton.constant = 20.scaleH
    }

    @objc func onClickSendButton() {
        pushViewController(VerifyPhoneNumberViewController())
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

//        spaceBottomButton.constant = 0 + keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
//        spaceBottomButton.constant = 0
    }
}
