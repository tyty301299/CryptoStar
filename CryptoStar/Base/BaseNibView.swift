//
//  BaseNibView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 23/05/2022.
//

import UIKit

class BaseNibView: UIView {
    @IBOutlet var contentView: UIView!
    
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
        contentView.frame = bounds
        addSubview(contentView)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
