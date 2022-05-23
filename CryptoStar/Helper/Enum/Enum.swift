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
    case createAcc = "Create a New Account"
    case loginPhone = "Login via Phone"
    case loginEmail = "Login via Email"
    case verifyPhone = "Verify phone number"
    case home = "Home"
    case otp = "Send OTP"
    case charts = "Charts"
    case setting = "Setting"
    case login = "Login"

    func getTitle() -> String {
        return rawValue
    }
}

enum TitleLabel: String, CaseIterable, TitleProtocol {
    case name = "YOUR NAME"
    case email = "EMAIL ID"
    case pass = "PASS WORD"
    case confirmPass = "CONFIRM PASSWORD"
    case phoneNumber = "Phone Number"
    case resend = "Resend"
    case login = "Login Now"
    case signup = "Signup Now"
    case accountNot = "Don't have an account?"

    func getTitle() -> String {
        return rawValue
    }
}
