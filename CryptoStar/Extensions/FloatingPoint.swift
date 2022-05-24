//
//  CGFloat.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 20/05/2022.
//

import UIKit

protocol scaleProtocol {
    func getScale() -> CGFloat
}

extension FloatingPoint where Self == Double {
    var scaleW: Self {
        return self * Self(Helper.isPad ? ratioIpadPro.width : ratioIphoneX.width)
    }

    var scaleH: Self {
        return self * Self(Helper.isPad ? ratioIpadPro.height : ratioIphoneX.height)
    }
}
