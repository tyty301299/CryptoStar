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

    var subString: String {
        return String(format: "%.2f", self)
    }

    var convertDoubletoPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.alwaysShowsDecimalSeparator = true
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter.string(from: self as NSNumber)!
    }
}
