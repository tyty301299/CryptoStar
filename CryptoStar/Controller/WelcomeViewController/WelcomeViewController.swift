//
//  WelcomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    @IBOutlet private weak var storeWatchLabel: UILabel!
    @IBOutlet private weak var robotImageView: UIImageView!
    @IBOutlet private weak var logoView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var loginEmailButton: UIButton!
    @IBOutlet private weak var loginPhoneButton: UIButton!
    
    @IBOutlet private weak var spaceImageViewAndStoreWatchLabelLC: NSLayoutConstraint!
    @IBOutlet private weak var spaceTitleLabelAndLogoImageLC: NSLayoutConstraint!
    @IBOutlet private weak var topLoginPhoneButtonLC: NSLayoutConstraint!
    @IBOutlet private weak var spaceTopLoginEmailButtonLC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayoutViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setupViews(){
        titleLabel.font = .sfProDisplay(font: .bold, size: 26)
        storeWatchLabel.font = .sfProDisplay(font: .regular, size: 18)
        loginPhoneButton.setUpButton(text: .loginPhone, background: .black, textColor: .white)
        loginEmailButton.setUpButton(text: .loginEmail, background: .black, textColor: .white)
    }
    
    func setupLayoutViews(){
        logoView.frame.size.width = 185.scaleW
        logoView.frame.size.height = 42.scaleH
        robotImageView.frame.size.width = 466.7.scaleW
        robotImageView.frame.size.height = 362.scaleW
        
        spaceImageViewAndStoreWatchLabelLC.constant = 37.4.scaleH
        spaceTitleLabelAndLogoImageLC.constant = 15.scaleW
        spaceTopLoginEmailButtonLC.constant = 18.scaleH
        topLoginPhoneButtonLC.constant = 14.scaleH
    }

    @IBAction func actionLoginEmail(_ sender: Any) {
        pushViewController(LoginEmailViewController())
    }

    @IBAction func actionLoginPhone(_ sender: Any) {
        pushViewController(LoginPhoneViewController())
    }
}
