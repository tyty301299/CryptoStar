//
//  Enum.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import Foundation

enum Color: String, CaseIterable {
    case backgroundColorButton = "#141A22"
    case titleColorButton = "#FBFBFB"
    case titleColorLabel = "#6E7F8D"
    case borderTextFieldColor = "#EFF0F4"
    case titleColorUser = "#006DFF"
    case cryptoUpColor = "#17B978"
    case cryptoDownColor = "#DC2F2F"
}

enum Font: String, CaseIterable {
    case medium = "SFProDisplay-Medium"
    case regular = "SFProDisplay-Regular"
    case semibold = "SFProDisplay-Semibold"
    case bold = "SFProDisplay-Bold"
}

protocol TitleProtocol {
    func getTitle() -> String
}

enum TitleNavigationBar: String, CaseIterable, TitleProtocol {
    case createAccount = "Create a New Account"
    case loginPhone = "Login via Phone"
    case loginEmail = "Login via Email"
    case verifyPhone = "Verify phone number"
    case home = "Home"
    case otp = "Send OTP"
    case charts = "Charts"
    case setting = "Setting"
    case login = "Login"
    case notificationTitleCreateAccount = "Sync across devices with your Account"
    case cretateAccountButton = "Create Account"
    func getTitle() -> String {
        return rawValue
    }
}

enum TitleLabel: String, CaseIterable, TitleProtocol {
    case yourName = "YOUR NAME"
    case emailID = "EMAIL ID"
    case passWord = "PASSWORD"
    case confirmPassWord = "CONFIRM PASSWORD"
    case phoneNumber = "Phone Number"
    case resend = "Resend"
    case loginNow = "Login Now"
    case signupNow = "Signup Now"
    case dontHaveAnAccount = "Don't have an account?"

    func getTitle() -> String {
        return rawValue
    }
}
