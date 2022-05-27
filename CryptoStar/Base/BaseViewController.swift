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
}

