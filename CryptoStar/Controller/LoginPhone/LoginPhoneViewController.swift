//
//  LoginPhoneViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class LoginPhoneViewController: BaseViewController, UITextFieldDelegate {
    @IBOutlet var navigationBarView: CustomNavigationBarView!
    @IBOutlet var topDataInputViewLC: NSLayoutConstraint!
    @IBOutlet var spaceBottomButtonLC: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var phoneNumberView: DataInputView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarView.setUpNavigationBarButton()
        navigationBarView.setupStyleNavigaitonBarLabel()

        navigationBarView.titleLabel.setTitle(title: TitleNavigationBar.loginPhone)

        topDataInputViewLC.constant = 237.scaleH
        spaceBottomButtonLC.constant = 20.scaleH

        phoneNumberView.dataInputTextField.delegate = self
        phoneNumberView.setUpTextLabel(text: .phoneNumber)
        phoneNumberView.setUpTextField(keyboardType: .numberPad)

        setupButton(customButton: sendButton, text: .otp, background: .black, textColor: .white)

        sendButton.addTarget(self, action: #selector(onClickSendButton), for: .touchUpInside)
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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
