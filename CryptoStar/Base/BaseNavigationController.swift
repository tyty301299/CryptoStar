//
//  BaseNavigationController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = true
        navigationBar.isHidden = true
        navigationBar.tintColor = .black
        setUpBackButton()
    }

    func setUpBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "backImage"),
            style: .done,
            target: self,
            action: nil
        )
    }
}
