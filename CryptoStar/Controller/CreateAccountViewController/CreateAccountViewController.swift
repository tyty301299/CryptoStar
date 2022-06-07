//
//  CreateAccountViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 23/05/2022.
//

import FirebaseAuth
import UIKit

class CreateAccountViewController: BaseViewController {
    @IBOutlet var topLayoutDataInputContainerStackView: NSLayoutConstraint!
    @IBOutlet var dataInputContainerStackView: UIStackView!
    @IBOutlet var yourNameView: DataInputView!
    @IBOutlet var confirmPassWordView: DataInputView!
    @IBOutlet var passWordView: DataInputView!
    @IBOutlet var emailView: DataInputView!
    @IBOutlet var createAccountButton: UIButton!
    @IBOutlet var navigationBarView: CustomNavigationBarView!

    @IBOutlet var loginNowLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarView.setUpNavigationBarButton()
        navigationBarView.setUpStyleNavigaitonBarLabel()
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        navigationBarView.titleLabel.setTitle(TitleNavigationBar.createAccount)
        navigationBarView.notificationLabel.isHidden = false
        navigationBarView.notificationLabel.setTitle(TitleNavigationBar.notificationTitleCreateAccount)

        createAccountButton.setUpButton(text: .cretateAccountButton, background: .black, textColor: .white)
        dataInputContainerStackView.spacing = 38.5.scaleH

        yourNameView.setUpTextLabel(text: .yourName)
        yourNameView.setUpTextField(keyboardType: .default)

        emailView.setUpTextLabel(text: .emailID)
        emailView.setUpTextField(keyboardType: .emailAddress)

        passWordView.setUpTextLabel(text: .passWord)
        passWordView.setUpTextField(keyboardType: .default, secureTextEntry: true)

        confirmPassWordView.setUpTextLabel(text: .confirmPassWord)
        confirmPassWordView.setUpTextField(keyboardType: .default, secureTextEntry: true)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapLoginNow = UITapGestureRecognizer(target: self, action: #selector(onTapLoginNow(sender:)))

        loginNowLabel.addGestureRecognizer(tapLoginNow)
        loginNowLabel.isUserInteractionEnabled = true
    }

    @objc func onTapLoginNow(sender: UITapGestureRecognizer) {
        popViewController()
    }

    @objc func keyboardWillShow(Notification: NSNotification) {
        guard let keyboardSize = (Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        topLayoutDataInputContainerStackView.constant = 237.scaleH - (keyboardSize.height / 3)
    }

    @objc func keyboardWillHide(Notification: NSNotification) {
        topLayoutDataInputContainerStackView.constant = 237.scaleH
    }

    override func viewDidLayoutSubviews() {
        passWordView.createLayerLineTextField()
        emailView.createLayerLineTextField()
        yourNameView.createLayerLineTextField()
        confirmPassWordView.createLayerLineTextField()
    }

    @IBAction func createAccountEmail(_ sender: Any) {
        guard let name = yourNameView.dataInputTextField.text, !name.isEmpty,
              let email = emailView.dataInputTextField.text, !email.isEmpty,
              let passWord = passWordView.dataInputTextField.text, !passWord.isEmpty,
              let confirmPassWord = confirmPassWordView.dataInputTextField.text, !confirmPassWord.isEmpty else { return }

        if passWord == confirmPassWord {
            AuthManager.shared.signInEmailLink(email: email, password: passWord) { result in
                switch result {
                case .success:
                    self.showAlert(title: "Success", message: "Create Account Sucess")

                    break
                case let .failure(error):
                    self.showAlert(title: "ERROR", message: error.localizedDescription)
                }
            }
        } else {
            showAlert(title: "PassWord", message: "Error")
        }
    }
}
