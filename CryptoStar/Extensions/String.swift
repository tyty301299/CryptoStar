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
}
