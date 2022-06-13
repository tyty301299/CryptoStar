//
//  LoginFaceIDViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 08/06/2022.
//

import LocalAuthentication
import UIKit

class LoginFaceIDViewController: BaseViewController {
    @IBOutlet var loginPinButton: UIButton!
    @IBOutlet var loginFaceIdButton: UIButton!
    @IBOutlet var pinView: DataInputView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LoginFaceID()
    }

  
    func LoginFaceID() {
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, _ in
                    DispatchQueue.main.async {
                        if success {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            print("Sorry!!... User did not authenticate successfully")
                        }
                    }
                }
            } else {
                showAlertFaceId()
            }
        } else {
            print("Ooops!!.. This feature is not supported.")
        }
    }

    func showAlertFaceId() {
        let alertController = UIAlertController(title: "", message: "Do you want to go through settings ?", preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Ok", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { success in
                    print("Settings opened: \(success)")
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    func setupViews() {
        let faceIdImage = UIImage(named: "faceId")
        loginFaceIdButton.tintColor = .white
        loginFaceIdButton.backgroundColor = .black
        loginFaceIdButton.setImage(faceIdImage, for: .normal)

        loginFaceIdButton.setCornerRadius(cornerRadius: 5)
        loginPinButton.setUpButton(text: .loginPin,
                                   background: .black,
                                   textColor: .white)

        pinView.setupTextField(keyboardType: .numberPad,
                               secureTextEntry: true)

        pinView.dataInputTextField.delegate = self
    }

    @IBAction func actionLoginFaceId(_ sender: Any) {
        LoginFaceID()
    }

    @IBAction func actionLoginPIN(_ sender: Any) {
        guard let text = pinView.dataInputTextField.text else {
            showAlert(title: .empty, message: "Not Data")
            return
        }
        let pinCode = KeyChainManager.shared.getPinCode()
        if pinCode == text {
            dismiss(animated: true)
        } else {
            showAlert(title: .errorTextField, message: "Wrong password")
        }
    }
}

extension LoginFaceIDViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let subStringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - subStringToReplace.count + string.count
        return count <= Limit.password
    }
}
