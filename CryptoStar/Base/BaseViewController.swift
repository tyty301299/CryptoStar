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
}
