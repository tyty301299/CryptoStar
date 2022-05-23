//
//  CGFloat.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 20/05/2022.
//

import UIKit

extension CGFloat {
    var scaleW: CGFloat {
        return (CGFloat(self) * (Helper.isPad ? ratioIpadPro.width : ratioIphoneX.width))
    }

    var scaleH: CGFloat {
        return (CGFloat(self) * (Helper.isPad ? ratioIpadPro.width : ratioIphoneX.width))
    }
}
