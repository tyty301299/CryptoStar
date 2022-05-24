//
//  CustomNavigationBarView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 20/05/2022.
//

import UIKit

class CustomNavigationBarView: BaseNibView {
    @IBOutlet var leadingBackButtonLC: NSLayoutConstraint!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!

    func setUpNavigationBarButton() {
        leadingBackButtonLC.constant = 25.scaleW
    }

    func setupStyleNavigaitonBarLabel() {
        titleLabel.font = .sfProDisplay(font: .medium, size: 20)
        titleLabel.textColor = .black
        notificationLabel.textColor = .hexStringToUIColor(color: .titleColorLabel)
        notificationLabel.font = .sfProDisplay(font: .regular, size: 18)
    }
}
