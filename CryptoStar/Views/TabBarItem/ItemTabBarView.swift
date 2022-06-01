//
//  ItemTabBarView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 29/05/2022.
//

import UIKit
class ItemTabBarView: UIView {
    let nameLable = UILabel()
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
        setupLable()
        setUpImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupComponent() {
        addSubview(containerView)
        containerView.addSubview(nameLable)
        containerView.addSubview(iconImageView)
    }

    private func animateItems() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
        }, completion: { _ in
            print("is Selected : \(self.isSelected)")
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
            self.nameLable.textColor = self.isSelected ? .black : UIColor.hexStringUIColor(color: .titleColorLabel)
        })
    }

    func setUpImageView() {
        iconImageView.image = UIImage(named: item.rawValue)
    }

    func setupLable() {
        nameLable.font = .sfProDisplay(font: .regular, size: 10.scaleW)
        nameLable.textColor = UIColor.hexStringUIColor(color: .titleColorLabel)
        nameLable.text = item.rawValue
    }

    func setupLayoutComponent() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let constraintContainerView = [
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraintContainerView)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraintImageView = [
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
        ]

        NSLayoutConstraint.activate(constraintImageView)

        nameLable.translatesAutoresizingMaskIntoConstraints = false
        let constraintLable = [
            nameLable.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameLable.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraintLable)
    }
}
