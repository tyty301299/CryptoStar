//
//  WelcomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class WelcomeViewController: BaseViewController {
    @IBOutlet weak var storeWatchLabel: UILabel!
    @IBOutlet weak var spaceTitleLabelAndLogoImage: NSLayoutConstraint!
    
    @IBOutlet weak var robotImageView: UIImageView!
    @IBOutlet var logoView: UIView!
    @IBOutlet var spaceTopLoginPhoneButton: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var topLayoutLoginPhoneButton: NSLayoutConstraint!
    @IBOutlet var loginEmailButton: UIButton!
    @IBOutlet var loginPhoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(customButton: loginPhoneButton, text: .loginPhone, background: .black, textColor: .white)
        setupButton(customButton: loginEmailButton, text: .loginEmail, background: .black, textColor: .white)
    }

    override func viewWillAppear(_ animated: Bool) {
        logoView.frame.size.width = 185.scaleW
        logoView.frame.size.height = 42.scaleH
        print(logoView.frame.size)
        titleLabel.font = .sfProDisplay(font: .bold, size: 26.scaleW)
        storeWatchLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)
        spaceTitleLabelAndLogoImage.constant = 15.scaleW
        robotImageView.frame.size.width = 466.7.scaleW
        robotImageView.frame.size.height = 362.scaleH
        print("Robot size :",robotImageView.frame.size)
        spaceTopLoginPhoneButton.constant = 18.scaleH
        topLayoutLoginPhoneButton.constant = 14.scaleH
    }

    @IBAction func loginEmail(_ sender: Any) {
        pushViewController(LoginEmailViewController())
    }

    @IBAction func loginPhone(_ sender: Any) {
        pushViewController(LoginPhoneViewController())
    }
}
