//
//  VerifyPhoneNumberViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 22/05/2022.
//

import UIKit

class VerifyPhoneNumberViewController: BaseViewController {
    @IBOutlet private var resendLabel: UILabel!
    @IBOutlet private var verificationPhoneNumberButton: UIButton!
    @IBOutlet private var otpView: OTPView!
    @IBOutlet private var navigationBarView: CustomNavigationBarView!
    @IBOutlet private var bottomVerificaionPhoneButtonLC: NSLayoutConstraint!
    @IBOutlet private var topResendLabelLC: NSLayoutConstraint!
    @IBOutlet private var topOTPViewLC: NSLayoutConstraint!
    var numberphone = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutViews()
        addGestureRecognizerResendLabel()
        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: .verifyPhone)
        otpView.becomeResponder()
        verificationPhoneNumberButton.setUpButton(text: .verifyPhone,
                                                  background: .black,
                                                  textColor: .white)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setupLayoutViews() {
        topOTPViewLC.constant = 237.scaleW
        topResendLabelLC.constant = 22.5.scaleW
        bottomVerificaionPhoneButtonLC.constant = 20.scaleW
    }

    func addGestureRecognizerResendLabel() {
        let tapResendLabel = UITapGestureRecognizer(target: self,
                                                    action: #selector(actionResendOTP(_:)))
        resendLabel.addGestureRecognizer(tapResendLabel)
        resendLabel.isUserInteractionEnabled = true
    }

    @objc func actionResendOTP(_ gesture: UITapGestureRecognizer) {
        guard numberphone.isNotEmpty else { return }
        AuthManager.shared.startAuth(phoneNumber: numberphone) { [weak self] result in
            switch result {
            case .success:
                break
            case let .failure(error):
                self?.showAlert(title: .errorTextField, message: error.localizedDescription)
            }
        }
    }

    @IBAction func actionLoginOTPPhone(_ sender: Any) {
        let otp = otpView.numTextField
        // TODO: [weak self]
        AuthManager.shared.verifyCode(smsCode: otp) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    self.appDelegate.setTabBarViewController()
                }
            case let .failure(error):
                self.showAlert(title: .errorTextField, message: error.localizedDescription)
            }
        }
    }
}
