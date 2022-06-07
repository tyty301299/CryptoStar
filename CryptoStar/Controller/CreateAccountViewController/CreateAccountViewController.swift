//
//  CreateAccountViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 23/05/2022.
//

import FirebaseAuth
import UIKit

class CreateAccountViewController: BaseViewController {
    @IBOutlet private var loginNowLabel: UILabel!
    @IBOutlet private var emailView: DataInputView!
    @IBOutlet private var passwordView: DataInputView!
    @IBOutlet private var yourNameView: DataInputView!
    @IBOutlet private var createAccountButton: UIButton!
    @IBOutlet private var confirmPasswordView: DataInputView!
    @IBOutlet private var dataInputContainerStackView: UIStackView!
    @IBOutlet private var navigationBarView: CustomNavigationBarView!

    @IBOutlet private var topDataInputContainerStackViewLC: NSLayoutConstraint!
    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: .createAccount,
                               notificationTitle: .notificationTitleCreateAccount)
        setupViews()
        notificationCenterKeyBoard()
        setupActivityIndicatorView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dataInputContainerStackView.spacing = 38.5.scaleH
        passwordView.createLayerLineTextField()
        emailView.createLayerLineTextField()
        yourNameView.createLayerLineTextField()
        confirmPasswordView.createLayerLineTextField()
    }

    func setupActivityIndicatorView() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
        view.addSubview(activityIndicator)
    }

    func notificationCenterKeyBoard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        let tapLoginNowLabel = UITapGestureRecognizer(target: self,
                                                      action: #selector(actionBackLoginEmailViewController(sender:)))

        loginNowLabel.addGestureRecognizer(tapLoginNowLabel)
        loginNowLabel.isUserInteractionEnabled = true
    }

    func setupViews() {
        emailView.setUpTextLabel(text: .emailID)
        emailView.setUpTextField(keyboardType: .emailAddress)
        yourNameView.setUpTextLabel(text: .yourName)
        yourNameView.setUpTextField(keyboardType: .default)
        passwordView.setUpTextLabel(text: .password)
        confirmPasswordView.setUpTextLabel(text: .confirmPassWord)
        yourNameView.dataInputTextField.delegate = self
        emailView.dataInputTextField.delegate = self
        passwordView.dataInputTextField.delegate = self
        confirmPasswordView.dataInputTextField.delegate = self
        createAccountButton.setUpButton(text: .cretateAccountButton,
                                        background: .black,
                                        textColor: .white)

        passwordView.setUpTextField(keyboardType: .default,
                                    secureTextEntry: true)

        confirmPasswordView.setUpTextField(keyboardType: .default,
                                           secureTextEntry: true)
    }

    // TODO: Fix function name
    @objc func actionBackLoginEmailViewController(sender: UITapGestureRecognizer) {
        popViewController()
    }

    // TODO: Fix parameter name
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let heightKeyBoard = (keyboardSize.height / 3)
        topDataInputContainerStackViewLC.constant = 237.scaleW - heightKeyBoard
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    // TODO: Fix parameter name
    @objc func keyboardWillHide(notification: NSNotification) {
        topDataInputContainerStackViewLC.constant = 237.scaleW
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func createAccountEmail(_ sender: Any) {
        // TODO: Validate email, password >= 8 characters
        guard let name = yourNameView.dataInputTextField.text, !name.isEmpty,
              let email = emailView.dataInputTextField.text, !email.isEmpty,
              let password = passwordView.dataInputTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordView.dataInputTextField.text, !confirmPassword.isEmpty else {
            showAlert(title: .empty, message: DataTextField.textFieldEmpty.getTitle())
            return
        }

        // FIXME: - check field empty
        if email.isNotContainsEmail {
            showAlert(title: .email, message: DataTextField.emailIsNot.getTitle())
        } else if password == confirmPassword {
            AuthManager.shared.signInEmailLink(email: email, password: password) { [weak self] result in
                switch result {
                case .success:
                    UIView.animate(withDuration: 1) {
                        self?.activityIndicator.startAnimating()
                    }
                    self?.activityIndicator.stopAnimating()
                case let .failure(error):
                    self?.showAlert(title: .errorTextField, message: error.localizedDescription)
                }
            }
        } else {
            showAlert(title: .password, message: DataTextField.password.getTitle())
        }
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let subStringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - subStringToReplace.count + string.count

        if textField == emailView.dataInputTextField &&
            textField == yourNameView.dataInputTextField {
            return count <= Limit.email
        }

        return count <= Limit.password
    }
}
