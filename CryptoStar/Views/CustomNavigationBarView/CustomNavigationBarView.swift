//
//  CustomNavigationBarView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 20/05/2022.
//

import UIKit

class CustomNavigationBarView: BaseNibView {
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private var leadingBackButtonLC: NSLayoutConstraint!

    func setupNavigationBarButton() {
        leadingBackButtonLC.constant = 25.scaleW
    }

    func setupStyleNavigationBarLabel() {
        titleLabel.font = .sfProDisplay(font: .medium, size: 20)
        titleLabel.textColor = .black
        notificationLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
        notificationLabel.font = .sfProDisplay(font: .regular, size: 18)
    }
}
