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
        loadFont()
    }

    func loadFont() {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.sfProDisplay(font: .medium, size: 20.scaleW),
        ]

        navigationController?.navigationBar.titleTextAttributes = attrs
    }
}

