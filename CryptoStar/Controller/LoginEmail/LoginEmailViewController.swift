//
//  LoginEmailViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 22/05/2022.
//

import FirebaseAuth
import UIKit

class LoginEmailViewController: BaseViewController, UIGestureRecognizerDelegate {
    @IBOutlet var accountContainerView: UIView!
    @IBOutlet var accountNotLabel: UILabel!
    @IBOutlet var sigupLabel: UILabel!
    @IBOutlet var topDataInputViewLC: NSLayoutConstraint!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var bottomLoginButtonLC: NSLayoutConstraint!
    @IBOutlet var emailView: DataInputView!
    @IBOutlet var passWordView: DataInputView!
    @IBOutlet var bottomLoginNowViewLC: NSLayoutConstraint!
    @IBOutlet var navigationBarView: CustomNavigationBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarView.setUpNavigationBarButton()
        navigationBarView.setUpStyleNavigaitonBarLabel()
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        navigationBarView.titleLabel.setTitle(TitleNavigationBar.loginEmail)
        loginButton.setUpButton(text: .login, background: .black, textColor: .white)

        emailView.setUpTextLabel(text: .emailID)
        emailView.setUpTextField(keyboardType: .emailAddress)

        passWordView.setUpTextLabel(text: .passWord)
        passWordView.setUpTextField(keyboardType: .default, secureTextEntry: true)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didsigupViewController(sender:)))
        sigupLabel.addGestureRecognizer(tapGesture)
        sigupLabel.isUserInteractionEnabled = true
    }

    @objc func didsigupViewController(sender: UITapGestureRecognizer) {
        pushViewController(CreateAccountViewController())
    }

    override func viewWillAppear(_ animated: Bool) {
        topDataInputViewLC.constant = 237.scaleH
        bottomLoginButtonLC.constant = 20.scaleH
        bottomLoginNowViewLC.constant = 64.scaleH
        accountNotLabel.font = .sfProDisplay(font: .regular, size: 18)
        sigupLabel.font = .sfProDisplay(font: .regular, size: 18)
        sigupLabel.setTitle(TitleLabel.signupNow)
        accountNotLabel.setTitle(TitleLabel.dontHaveAnAccount)
    }

    override func viewDidLayoutSubviews() {
        emailView.createLayerLineTextField()
        passWordView.createLayerLineTextField()
    }

    @IBAction func loginEmail(_ sender: Any) {
        guard let email = emailView.dataInputTextField.text, !email.isEmpty,
              let passWord = passWordView.dataInputTextField.text, !passWord.isEmpty else {
            return
        }

        AuthManager.shared.signInEmail(email: email, password: passWord.MD5) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.appDelegate.setTabBarRootViewController()
                }
                break
            case let .failure(error):
                self.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }
    }
}
