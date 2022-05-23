//
//  Float.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 20/05/2022.
//

import UIKit

extension Double {
    var scaleW: CGFloat {
        return (CGFloat(self) * raitoX.width)
    }

    var scaleH: CGFloat {
        return (CGFloat(self) * raitoX.height)
    }
}
