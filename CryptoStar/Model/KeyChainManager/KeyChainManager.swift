//
//  KeyChainManager.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 08/06/2022.
//
import Foundation
import Security
enum ClosureResultKeyChain {
    case success(data: String)
    case failure(error: Error)
}

class KeyChainManager {
    static var shared = KeyChainManager()

    func getPinCode() -> String? {
        guard let data = load(key: "PinCode") else { return nil }
        return String(data: data, encoding: .utf8)
    }

    @discardableResult func setPinCode(pinCode: String) -> Bool {
        guard let data = pinCode.data(using: .utf8) else { return false }
        save(key: "PinCode", data: data)
        return true
    }

    @discardableResult func deletePinCode(pinCode: String) -> Bool {
        guard let data = pinCode.data(using: .utf8) else { return false }
        delete(key: "PinCode", data: data)
        return true
    }

    @discardableResult private func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data] as [String: Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    @discardableResult private func delete(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data] as [String: Any]

        SecItemDelete(query as CFDictionary)
        return SecItemDelete(query as CFDictionary)
    }

    private func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne] as [String: Any]

        var dataTypeRef: AnyObject?

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
}
