//
//  WelcomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class WelcomeViewController: BaseViewController {
    @IBOutlet var storeWatchLabel: UILabel!
    @IBOutlet var spaceTitleLabelAndLogoImageLC: NSLayoutConstraint!
    @IBOutlet var robotImageView: UIImageView!
    @IBOutlet var logoView: UIView!
    @IBOutlet var spaceTopLoginPhoneButtonLC: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var topLoginPhoneButtonLC: NSLayoutConstraint!
    @IBOutlet var loginEmailButton: UIButton!
    @IBOutlet var loginPhoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = .sfProDisplay(font: .bold, size: 26.scaleW)
        storeWatchLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)

        loginPhoneButton.setUpButton(text: .loginPhone, background: .black, textColor: .white)
        loginEmailButton.setUpButton(text: .loginEmail, background: .black, textColor: .white)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoView.frame.size.width = 185.scaleW
        logoView.frame.size.height = 42.scaleH

        robotImageView.frame.size.width = 466.7.scaleW
        robotImageView.frame.size.height = 362.scaleH

        spaceTitleLabelAndLogoImageLC.constant = 15.scaleW
        spaceTopLoginPhoneButtonLC.constant = 18.scaleH
        topLoginPhoneButtonLC.constant = 14.scaleH
    }

    @IBAction func loginEmail(_ sender: Any) {
        pushViewController(LoginEmailViewController())
    }

    @IBAction func loginPhone(_ sender: Any) {
        pushViewController(LoginPhoneViewController())
    }
}
