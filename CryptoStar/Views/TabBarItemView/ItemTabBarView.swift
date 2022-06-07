//
//  ItemTabBarView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 29/05/2022.
//

import UIKit
class ItemTabBarView: UIView {
    let nameLabel = UILabel()
    let iconImageView = UIImageView()
    let containerView = UIView()
    let index: Int
    var isSelected = false {
        didSet {
            iconImageView.image = item.selectedIcon
            animateItems()
        }
    }

    let item: TabItem

    init(with item: TabItem, index: Int) {
        self.item = item
        self.index = index
        super.init(frame: .zero)

        setupComponent()
        setupLayoutComponent()
        setupLabel()
        setUpImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupComponent() {
        addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(iconImageView)
    }

    private func animateItems() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
        }, completion: { _ in
            print("is Selected : \(self.isSelected)")
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
            self.nameLabel.textColor = self.isSelected ? .black : UIColor.hexStringUIColor(color: .titleColorLabel)
        })
    }

    private func setUpImageView() {
        iconImageView.image = UIImage(named: item.rawValue)
    }

    private func setupLabel() {
        nameLabel.font = .sfProDisplay(font: .regular, size: 10.scaleW)
        nameLabel.textColor = UIColor.hexStringUIColor(color: .titleColorLabel)
        nameLabel.text = item.rawValue
    }

    private func setupLayoutComponent() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let constraintContainerView = [
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraintContainerView)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraintImageView = [
            // iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 20.scaleW),
            iconImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 20.scaleW),
        ]

        NSLayoutConstraint.activate(constraintImageView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraintLabel = [
            // nameLable.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 2.scaleW),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
        ]
        NSLayoutConstraint.activate(constraintLabel)
    }
}
