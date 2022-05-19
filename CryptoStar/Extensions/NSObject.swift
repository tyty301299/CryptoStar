//
//  NSObject+Exts.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import Foundation

extension NSObject {
    var className: String {
        String(describing: type(of: self))
    }

    class var className: String {
        String(describing: self)
    }
}
