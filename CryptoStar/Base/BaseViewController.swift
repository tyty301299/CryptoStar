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

    func setupButton(customButton: UIButton, text: TitleNavigationBar, background: UIColor, textColor: UIColor) {
        customButton.layer.cornerRadius = customButton.frame.size.height * (10 / 48)
        customButton.backgroundColor = background
        customButton.setFontButton(title: text, textColor: textColor)
    }

    func setTitle(text: String) {
        title = text
    }

    func loadFont() {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.sfProDisplay(font: .medium, size: 20.scaleW),
        ]

        navigationController?.navigationBar.titleTextAttributes = attrs
    }

    func backViewController() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "backImage"),
            style: .done,
            target: self,
            action: #selector(backButtonPressed)
        )
    }

    @objc func backButtonPressed() {
        print("back")

        popViewController()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension UITextField: UITextFieldDelegate {
}
