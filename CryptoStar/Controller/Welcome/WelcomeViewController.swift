//
//  WelcomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class WelcomeViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginEmailButton: UIButton!
    @IBOutlet weak var loginPhoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(customButton: loginPhoneButton, text: "Login via Phone", background: .black, textColor: .white)
        setupButton(customButton: loginEmailButton, text: "Login via Email", background: .black, textColor: .white)
       
       
    }
    
    @IBAction func loginEmail(_ sender: Any) {
        
    }
    
    @IBAction func loginPhone(_ sender: Any) {
    }
}
