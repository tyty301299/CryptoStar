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
    @IBOutlet var phoneNumberView: DataInputView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarView.setUpButton()
        navigationBarView.setupStyleLabel()
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        navigationBarView.titleLabel.setTitle(title: TitleNavigationBar.loginPhone)

        topLayoutDataInputView.constant = 237.scaleH
        spaceBottomButton.constant = 20.scaleH

        phoneNumberView.dataInputTextField.delegate = self
        phoneNumberView.setUpTextLabel(text: .phoneNumber)

        phoneNumberView.setUpTextField(keyboardType: .numberPad)
        setupButton(customButton: sendButton, text: .otp, background: .black, textColor: .white)

        sendButton.addTarget(self, action: #selector(onClickSendButton), for: .touchDown)
    }

    @objc func onClickSendButton() {
        pushViewController(VerifyPhoneNumberViewController())
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        phoneNumberView.layoutIfNeeded()
        phoneNumberView.createLayerLineTextField()
    }
}
