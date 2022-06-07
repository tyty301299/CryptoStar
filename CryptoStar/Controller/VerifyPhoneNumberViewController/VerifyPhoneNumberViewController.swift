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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var bottomVerificaionPhoneButtonLC: NSLayoutConstraint!
    @IBOutlet private var topResendLabelLC: NSLayoutConstraint!
    @IBOutlet private var topOTPViewLC: NSLayoutConstraint!

    var numberphone = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
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
        setupLayoutViews()
    }
    
    func setupActivityIndicatorView(){
        activityIndicator.center = self.view.center
        activityIndicator.frame.size.height = 100
        activityIndicator.frame.size.width = 100
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
    }

    func setupLayoutViews() {
        topOTPViewLC.constant = 237.scaleW
        topResendLabelLC.constant = 22.5.scaleW
        bottomVerificaionPhoneButtonLC.constant = 20.scaleW
    }

    func addGestureRecognizerResendLabel() {
        let tapResendLabel = UITapGestureRecognizer(target: self,
                                                    action: #selector(actionResend(_:)))
        resendLabel.addGestureRecognizer(tapResendLabel)
        resendLabel.isUserInteractionEnabled = true
    }

    @objc func actionResend(_ gesture: UITapGestureRecognizer) {
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

    @IBAction func actionLoginSMSPhone(_ sender: Any) {
        let sms = otpView.numTextField
        //TODO: [weak self]
        AuthManager.shared.verifyCode(smsCode: sms) { [weak self] result in
            switch result {
            case .success:
                self?.activityIndicator.hidesWhenStopped = false
                self?.activityIndicator.startAnimating()
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    self?.activityIndicator.hidesWhenStopped = true
                    self?.activityIndicator.stopAnimating()
                     self?.appDelegate.setTabBarViewController()
                }
                
            case let .failure(error):
                self?.showAlert(title: .errorTextField, message: error.localizedDescription)
            }
        }
    }
}
