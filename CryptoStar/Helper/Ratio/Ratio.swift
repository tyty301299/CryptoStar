//
//  ScreenSize.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

struct Ratio {
    static let iphoneX = CGSize(
        width: UIScreen.main.bounds.width / 375,
        height: UIScreen.main.bounds.height / 812
    )
    static let ipad = CGSize(width: 1.3, height: 1.3)
}
