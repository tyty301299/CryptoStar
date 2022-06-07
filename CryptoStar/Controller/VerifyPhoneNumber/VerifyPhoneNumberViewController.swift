//
//  VerifyPhoneNumberViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 22/05/2022.
//

import UIKit

class VerifyPhoneNumberViewController: BaseViewController {
    @IBOutlet var bottomVerifyPhoneButtonLC: NSLayoutConstraint!
    @IBOutlet var topResendLabelLC: NSLayoutConstraint!
    @IBOutlet var resendLabel: UILabel!
    @IBOutlet var topOTPViewLC: NSLayoutConstraint!
    @IBOutlet var verifyPhoneNumButton: UIButton!
    @IBOutlet var otpView: OTPView!
    @IBOutlet var navigationBarView: CustomNavigationBarView!
    var phone: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarView.setUpNavigationBarButton()
        navigationBarView.setUpStyleNavigaitonBarLabel()
        navigationBarView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchDown)
        navigationBarView.titleLabel.setTitle(TitleNavigationBar.verifyPhone)

        verifyPhoneNumButton.setUpButton(text: .verifyPhone, background: .black, textColor: .white)
        let tapResendLabel = UITapGestureRecognizer(target: self, action: #selector(wasTappedResend(_:)))
        tapResendLabel.numberOfTapsRequired = 1
        tapResendLabel.numberOfTouchesRequired = 1
        resendLabel.addGestureRecognizer(tapResendLabel)
        resendLabel.isUserInteractionEnabled = true
        otpView.becomeResponder()
    }

    @objc func wasTappedResend(_ gesture: UITapGestureRecognizer) {
        guard !phone.isEmpty else { return }
        AuthManager.shared.startAuth(phoneNumber: phone) { [weak self] result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self?.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topOTPViewLC.constant = 237.scaleH
        topResendLabelLC.constant = 22.5.scaleH
        bottomVerifyPhoneButtonLC.constant = 20.scaleH
    }

    @IBAction func loginSMSPhone(_ sender: Any) {
        let sms = otpView.numTextField
        print(sms)
        AuthManager.shared.verifyCode(smsCode: sms) { result in
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
