//
//  CGFloat.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 20/05/2022.
//

import UIKit

extension FloatingPoint where Self == Double {
    var scaleW: CGFloat {
        return (CGFloat(self) * (Helper.isPad ? Ratio.ipad.width : Ratio.iphoneX.width))
    }

    var scaleH: CGFloat {
        return (CGFloat(self) * (Helper.isPad ? Ratio.ipad.height : Ratio.ipad.height))
    }
}
