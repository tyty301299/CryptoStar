//
//  TitleTabBarView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 25/05/2022.
//

import UIKit

class TitleTabBarView: BaseNibView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var trailingAddButtonLC: NSLayoutConstraint!
    @IBOutlet var leadingTitleLabelLC: NSLayoutConstraint!
    @IBOutlet var bottomTitleLabelLC: NSLayoutConstraint!
    override func setNeedsLayout() {
        super.setNeedsLayout()
        setupLayoutView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupLayoutView() {
        trailingAddButtonLC.constant = 30.scaleW
        leadingTitleLabelLC.constant = 30.scaleW
        bottomTitleLabelLC.constant = 30.scaleW
    }

    override func initView() {
        super.initView()
        setupCornerRadius()
    }

    func setupCornerRadius() {
        contentView.layer.applyCornerRadiusShadow(color: .black.withAlphaComponent(0.5),
                                                  alpha: 0.5,
                                                  x: 0, y: 2,
                                                  cornerRadiusValue: 10)
    }

    func navigationBarSelectIndex(type: TabbarType) {
        setupTitleLabel(type: type)
        isHiddenAddButton(type: type)
       
    }

    func setupTitleLabel(type: TabbarType) {
        titleLabel.textColor = .black
        titleLabel.font = .sfProDisplay(font: .regular, size: 18)
        isHiddenAddButton(type: type)
        switch type {
        case .home:
            titleLabel.setTitle(TitleNavigationBar.home)
        case .chart:
            titleLabel.setTitle(TitleNavigationBar.charts)
        case .setting:
            titleLabel.setTitle(TitleNavigationBar.setting)
        }
    }

    private func isHiddenAddButton(type: TabbarType) {
        switch type {
        case .chart:
            addButton.isHidden = false

        default:
            addButton.isHidden = true
        }
    }
}
