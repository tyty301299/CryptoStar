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

        let originFrame = view.frame
        view.frame = CGRect(x: originFrame.minX, y: -125, width: originFrame.width, height: originFrame.height)
    }

    deinit {
        print("[HOT] \(self.className) deinit")
    }

    func backViewController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "backImage"),
            style: .done,
            target: self,
            action: #selector(backButtonPressed)
        )
    }

    @objc func backButtonPressed() {
        popViewController()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
