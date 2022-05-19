//
//  WelcomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class WelcomeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.font = .sfProDisplay(font: .semibold, size: 20)
        label.text = "Ty Nguyen"

        view.addSubview(label)
        label.center = view.center
    }
}
