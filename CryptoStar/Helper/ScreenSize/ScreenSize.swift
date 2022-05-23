//
//  ScreenSize.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit
let ratioIphoneX = ScreenSize.screenSizeIphoneX
let ratioIpadPro = ScreenSize.screenSizeIpad
struct ScreenSize {
    static let screenSizeIphoneX = CGSize(
        width: UIScreen.main.bounds.width / 375,
        height: UIScreen.main.bounds.height / 812)
    static let screenSizeIpad = CGSize(
        width: 1.3,
        height: 1.3)
}
