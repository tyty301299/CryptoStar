//
//  UserDefaultUtils.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 02/06/2022.
//

import Foundation

class UserDefaultUtils {
    private static let shared = UserDefaultUtils()
    private let standard = UserDefaults.standard
    
    private init() {}
    
    func set(_ value: Any?, forKey defaultName: String){
        standard.set(value, forKey: defaultName)
    }
    
    func get<T>(forKey key: UserDefaultKey, _ defaultValue: T?) -> T? {
        return (standard.value(forKey:key.rawValue) as? T) ?? defaultValue
    }
}

enum UserDefaultKey: String {
    case email = "email"
    case password = "password"
    case faceID
}

extension UserDefaultUtils {
    static var email: String {
        get {
            shared.get(forKey: UserDefaultKey.email, "")!
        }
        set {
            shared.set(newValue, forKey: UserDefaultKey.email.rawValue)
        }
    }
    
    static var password: String {
        get {
            shared.get(forKey: UserDefaultKey.password, "")!
        }
        set {
            shared.set(newValue, forKey: UserDefaultKey.password.rawValue)
        }
    }

    static var isFaceID: Bool {
        get {
            shared.get(forKey: UserDefaultKey.faceID, false) ?? false
        }
        set {
            shared.set(newValue, forKey: UserDefaultKey.faceID.rawValue)
        }
    }
}
