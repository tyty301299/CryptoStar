//
//  CustomNavigationBarView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 20/05/2022.
//

import UIKit

class CustomNavigationBarView: UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet var leadingLayoutBackButton: NSLayoutConstraint!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    private func initView() {
        Bundle.main.loadNibNamed(className, owner: self)

        containerView.frame = bounds
        addSubview(containerView)

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    func setUpButton() {
        leadingLayoutBackButton.constant = 25.scaleW
//        backButton.contentMode = .left
//        let image = UIImage(named: "backImage")
//        backButton.setImage(image, for: .normal)
    }

    func setupStyleLabel() {
        titleLabel.font = .sfProDisplay(font: .medium, size: 20)
        titleLabel.textColor = .black
        notificationLabel.textColor = .hexStringToUIColor(color: .titleColorLabel)
        notificationLabel.font = .sfProDisplay(font: .regular, size: 18)
    }
}
