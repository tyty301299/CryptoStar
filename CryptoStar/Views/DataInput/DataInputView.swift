//
//  DataInputView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class DataInputView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet var dataInputTextField: UITextField!
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

    func setUpTextLabel(text: TitleLabel) {
        titleLabel.text = text.rawValue
        titleLabel.textColor = UIColor.hexStringToUIColor(color: .titleColorLabel)
    }
    func setUpTextLabel(text: TitleLabel,size: CGFloat,color: UIColor) {
        titleLabel.text = text.rawValue
        titleLabel.textColor = UIColor.hexStringToUIColor(color: .titleColorLabel)
    }

    func setUpTextField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: contentView.frame.height - 0.5,
                                  width: contentView.frame.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.hexStringToUIColor(color: .titleColorLabel).cgColor
        dataInputTextField.borderStyle = .none
        contentView.layer.addSublayer(bottomLine)
    }
}
