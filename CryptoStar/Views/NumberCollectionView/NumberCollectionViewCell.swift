//
//  NumberCollectionViewCell.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 05/06/2022.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    @IBOutlet var numberButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupNumberButton(text: String) {
        numberButton.setFontButton(text: text, textColor: .black, size: 26, font: .regular)
    }

    func setupImageButton() {
        let backImage = UIImage(named: Helper.isPad ? "backNumberPadIpad" : "backNumberPadIphone")
        numberButton.setImage(backImage, for: .normal)
    }
}
