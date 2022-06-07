//
//  LoginEmailViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 22/05/2022.
//

import FirebaseAuth
import UIKit

class LoginEmailViewController: BaseViewController, UIGestureRecognizerDelegate {
    @IBOutlet private var signUpLabel: UILabel!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var emailView: DataInputView!
    @IBOutlet private var passwordView: DataInputView!
    @IBOutlet private var accountContainerView: UIView!
    @IBOutlet private var dontHaveAnAccountLabel: UILabel!
    @IBOutlet private var navigationBarView: CustomNavigationBarView!

    @IBOutlet private var topDataInputViewLC: NSLayoutConstraint!
    @IBOutlet private var bottomLoginButtonLC: NSLayoutConstraint!
    @IBOutlet private var bottomLoginNowViewLC: NSLayoutConstraint!
    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addGestureRecognizerSignUpLabel()
        setupLabels()
        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: .loginEmail)
        setupActivityIndicatorView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailView.createLayerLineTextField()
        passwordView.createLayerLineTextField()
        topDataInputViewLC.constant = 237.scaleW
        bottomLoginButtonLC.constant = 20.scaleW
        bottomLoginNowViewLC.constant = 64.scaleW
    }

    func setupActivityIndicatorView() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
        view.addSubview(activityIndicator)
    }

    func setupLabels() {
        dontHaveAnAccountLabel.font = .sfProDisplay(font: .regular, size: 18)
        signUpLabel.font = .sfProDisplay(font: .regular, size: 18)
        signUpLabel.setTitle(TitleLabel.signupNow)
        dontHaveAnAccountLabel.setTitle(TitleLabel.dontHaveAnAccount)
    }

    func addGestureRecognizerSignUpLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionSignUpViewController(sender:)))
        signUpLabel.addGestureRecognizer(tapGesture)
        signUpLabel.isUserInteractionEnabled = true
    }

    func setupViews() {
        loginButton.setUpButton(text: .login,
                                background: .black,
                                textColor: .white)

        emailView.setUpTextLabel(text: .emailID)
        emailView.setUpTextField(keyboardType: .emailAddress)
        passwordView.setUpTextLabel(text: .password)
        passwordView.setUpTextField(keyboardType: .default,
                                    secureTextEntry: true)
        emailView.dataInputTextField.delegate = self
        passwordView.dataInputTextField.delegate = self
    }

    // MARK: Actions

    @objc func actionSignUpViewController(sender: UITapGestureRecognizer) {
        pushViewController(CreateAccountViewController())
    }

    @IBAction func actionLoginEmail(_ sender: Any) {
        guard let email = emailView.dataInputTextField.text, email.isNotEmpty,
              let password = passwordView.dataInputTextField.text, password.isNotEmpty else {
            return
        }

        AuthManager.shared.signInEmail(email: email, password: password.MD5) { [weak self] result in
            switch result {
            case .success:
                UIView.animate(withDuration: 3) {
                    self?.activityIndicator.startAnimating()
                }
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.appDelegate.setTabBarViewController()
                }
            case let .failure(error):
                self?.showAlert(title: .errorTextField, message: error.localizedDescription)
            }
        }
    }
}

extension LoginEmailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let subStringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - subStringToReplace.count + string.count

        if textField == emailView.dataInputTextField {
            return count <= Limit.email
        }

        return count <= Limit.password
    }
}
