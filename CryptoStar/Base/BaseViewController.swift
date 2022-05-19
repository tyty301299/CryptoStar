//
//  BaseController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[HOT] \(className) init")
    }

    deinit {
        print("[HOT] \(self.className) deinit")
    }

    func setupButton(customButton: UIButton, text: String, background: UIColor, textColor: UIColor) {
        customButton.layer.cornerRadius = customButton.frame.size.height * ( 10 / 48)
        customButton.setTitle(text, for: .normal)
        customButton.backgroundColor = background
        customButton.setTitleColor(textColor, for: .normal)
        customButton.titleLabel?.font = .sfProDisplay(font: .semibold, size: 16)
    }
}
