//
//  ScreenSize.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit
let raitoX = ScreenSize.screenSizeX
struct ScreenSize {
    static let screenSizeX = CGSize(
        width: UIScreen.main.bounds.width / 375,
        height: UIScreen.main.bounds.height / 812)
}
