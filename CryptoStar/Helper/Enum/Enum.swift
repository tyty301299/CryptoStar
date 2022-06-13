//
//  Enum.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

enum StatusCoin: String, CaseIterable {
    case up
    case down
}

extension StatusCoin {
    var iconImage: UIImage {
        switch self {
        case .up:
            return UIImage(named: "upCoin")!
        case .down:
            return UIImage(named: "downCoin")!
        }
    }

    var textColor: UIColor {
        switch self {
        case .up:
            return UIColor.hexStringUIColor(color: .cryptoUpColor)
        case .down:
            return UIColor.hexStringUIColor(color: .cryptoDownColor)
        }
    }
}

enum Color: String, CaseIterable {
    case backgroundColorButton = "141A22"
    case titleColorButton = "FBFBFB"
    case titleColorLabel = "6E7F8D"
    case borderTextFieldColor = "EFF0F4"
    case titleColorUser = "006DFF"
    case cryptoUpColor = "17B978"
    case cryptoDownColor = "DC2F2F"
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
    case loginPin = "Login PIN"
    case token = "Token"
    case notificationTitleCreateAccount = "Sync across devices with your Account"
    case securePIN = "Secure your portfolio with a PIN"
    case cretateAccountButton = "Create Account"
    case createPINButton = "Create PIN"
    case verifiPINButton = "Verify PIN"
    case createPIN = "Create a Secured PIN"
    case verifyPIN = "Verify a Secured PIN"
    case isEmptyData = ""
    case privacyAndPolicy = "Privacy And Policy"
    case aboutUs = "About Us"
    func getTitle() -> String {
        return rawValue
    }

    var url: String {
        switch self {
        case .createAccount:
            fallthrough
        case .loginPhone:
            fallthrough
        case .loginEmail:
            fallthrough
        case .verifyPhone:
            fallthrough
        case .home:
            fallthrough
        case .otp:
            fallthrough
        case .charts:
            fallthrough
        case .setting:
            fallthrough
        case .login:
            fallthrough
        case .loginPin:
            fallthrough
        case .token:
            fallthrough
        case .notificationTitleCreateAccount:
            fallthrough
        case .securePIN:
            fallthrough
        case .cretateAccountButton:
            fallthrough
        case .createPINButton:
            fallthrough
        case .verifiPINButton:
            fallthrough
        case .createPIN:
            fallthrough
        case .verifyPIN:
            fallthrough
        case .isEmptyData:
            return ""
        case .privacyAndPolicy:
            return "https://support.apple.com/"
        case .aboutUs:
            return "https://www.apple.com/business/"
        }
    }
}

enum entityData: String, CaseIterable, TitleProtocol {
    case coinEntity = "CoinEntity"
    case id
    case logo
    case checkSwitch

    func getTitle() -> String {
        return rawValue
    }
}

enum TitleLabel: String, CaseIterable, TitleProtocol {
    case yourName = "YOUR NAME"
    case emailID = "EMAIL ID"
    case password = "PASSWORD"
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

enum TabbarType: Int {
    case home
    case chart
    case setting
}

enum ClosureResult<T: Codable> {
    case success(data: T)
    case failure(error: Error)
}

enum ClosureResultCoinEntities {
    case success(data: CoinEntities)
    case failure(error: Error)
}

enum TabItem: String, CaseIterable {
    case home = "Home"
    case chart = "Charts"
    case setting = "Setting"
}

extension TabItem {
    var viewController: UINavigationController {
        switch self {
        case .home:
            return BaseNavigationController(rootViewController: HomeViewController())
        case .chart:
            return BaseNavigationController(rootViewController: ChartsViewController())

        case .setting:
            return BaseNavigationController(rootViewController: SettingViewController())
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(named: "home")!
        case .chart:
            return UIImage(named: "charts")!
        case .setting:
            return UIImage(named: "setting")!
        }
    }

    var selectedIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "homeIphone")!
        case .chart:
            return UIImage(named: "chartsIphone")!
        case .setting:
            return UIImage(named: "settingIphone")!
        }
    }

    var displayTitle: String {
        return rawValue.capitalized(with: nil)
    }
}

enum HTTPMethod: String {
    case GET
    case POST
}

enum APICoin {
    case getLogo(id: Int)
    case getCoin(start: Int, limit: Int)
    case postCoin(start: Int, limit: Int)
    static let endPoint = "https://pro-api.coinmarketcap.com"
    static let version = "v1/"
    static let version2 = "v2/"
    var method: HTTPMethod {
        switch self {
        case .getCoin:
            return HTTPMethod.GET
        case .postCoin:
            return HTTPMethod.POST
        case .getLogo:
            return HTTPMethod.GET
        }
    }

    var id: String {
        switch self {
        case let .getLogo(id):
            return "\(id)"
        case let .getCoin(start, _):
            return "\(start)"
        case let .postCoin(start, _):
            return "\(start)"
        }
    }

    var parameter: [String: Any]? {
        switch self {
        case let .getCoin(start, limit):
            return ["start": start, "limit": limit]
        case let .postCoin(start, limit):
            return ["start": start, "limit": limit]
        case let .getLogo(id):
            return ["id": id]
        }
    }

    var header: [String: String] {
        return ["X-CMC_PRO_API_KEY": "aa035776-0761-4b56-b796-4c07888ce670"]
    }

    var url: String? {
        switch self {
        case .getCoin:
            return APICoin.endPoint + "/" + APICoin.version + "cryptocurrency/listings/latest"
        case .postCoin:
            return APICoin.endPoint + "/" + APICoin.version + "cryptocurrency/listings/latest"
        case .getLogo:
            return APICoin.endPoint + "/" + APICoin.version2 + "cryptocurrency/info"
        }
    }
}

enum ClosureResultCoin<T: Codable> {
    case success(data: T)
    case failure(error: Error)
    case disconnected(data: String)
}

enum ClosureResultCoreData {
    case success(data: [CoinEntity])
    case failure(error: Error)
    case disconnected(data: String)
}

enum ClosureResultLogo {
    case success(data: String)
    case failure(error: Error)
    case disconnected(data: String)
}

enum DataTextField: String, CaseIterable {
    case empty = "Empty"
    case textFieldEmpty = "TextField Empty"
    case email = "Email"
    case emailIsNot = "Email Is Not"
    case errorTextField = "Error"
    case logo = "Disconnect Logo"
    case password = "Password"
    case wrongPassword = "wrong password"
    case success = "Success"
    case disconnected
    case errorUpdateCoreData = "Error Update Core Data"
    case errorCoreData = "Core Data"
    case errorMessage = "Error Message"
    case errorFaceId = "Face ID"
    func getTitle() -> String {
        return rawValue
    }
}

extension Dictionary where Key == String, Value == Any {
    func dictionaryToURLItem() -> [URLQueryItem] {
        return map { URLQueryItem(name: $0, value: String(describing: $1)) }
    }
}
