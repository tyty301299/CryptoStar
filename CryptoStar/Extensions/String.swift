//
//  String.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 30/05/2022.
//

import CryptoKit
import UIKit

extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }

    var subString: String {
        return String(format: "%.2f", self)
    }

    var isNotContainsEmail: Bool {
        let ischaracters = "@"
        if contains(ischaracters) {
            return false
        }
        return true
    }
}

extension Optional where Wrapped == String {
    var getOrEmpty: String {
        if self == nil {
            return ""
        } else {
            return self!
        }
    }
}

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

extension String {
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
}
