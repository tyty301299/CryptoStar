//
//  WelcomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    @IBOutlet weak var spaceTopLoginPhoneButton: NSLayoutConstraint!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var topLayoutLoginPhoneButton: NSLayoutConstraint!
    @IBOutlet var loginEmailButton: UIButton!
    @IBOutlet var loginPhoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(customButton: loginPhoneButton, text: .loginPhone, background: .black, textColor: .white)
        setupButton(customButton: loginEmailButton, text: .loginEmail, background: .black, textColor: .white)
    }
    override func viewWillAppear(_ animated: Bool) {
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
