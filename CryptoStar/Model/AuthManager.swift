//
//  AuthManager.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 26/05/2022.
//

import FirebaseAuth
import Foundation

class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    private var verificationID: String?
    func startAuth(phoneNumber: String, completion: @escaping (ClosureResult<String>) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    completion(.failure(error: error))
                    return
                }
                guard let verificationID = verificationID else {
                    return
                }
                completion(.success(data: "success"))
                self.verificationID = verificationID
            }
    }

    func verifyCode(smsCode: String, completion: @escaping (ClosureResult<String>) -> Void) {
        guard let verificationID = verificationID else {
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: smsCode)
        auth.signIn(with: credential) { _, error in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            completion(.success(data: "success"))
        }
    }

    func signInEmail(email: String, password: String, completion: @escaping (ClosureResult<String>) -> Void) {
        auth.signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            completion(.success(data: "success"))
        }
    }

    func signUpEmail(email: String, password: String, completion: @escaping (ClosureResult<String>) -> Void) {
        auth.createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error: error))
                return
            }

            completion(.success(data: "success"))
        }
    }

    func signInEmailLink(email: String, password: String, completion: @escaping (ClosureResult<String>) -> Void) {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://cryptostar-25b8b.firebaseapp.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.dynamicLinkDomain = "cryptostar.page.link"
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        print(Bundle.main.bundleIdentifier!)
        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            UserDefaults.standard.set(email, forKey: "Email")
            UserDefaults.standard.set(password, forKey: "Pass")
            completion(.success(data: "success"))
        }
    }
}
