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
    @IBOutlet var bottomAddButtonLC: NSLayoutConstraint!
    @IBOutlet var bottomTitleLabelLC: NSLayoutConstraint!
    @IBOutlet var trailingAddButtonLC: NSLayoutConstraint!
    @IBOutlet var leadingTitleLabelLC: NSLayoutConstraint!

    func setupLayoutView() {
        trailingAddButtonLC.constant = 30.scaleW
        leadingTitleLabelLC.constant = 30.scaleW
        bottomAddButtonLC.constant = 30.scaleH
        bottomTitleLabelLC.constant = 33.scaleH
        roundCorners(corners: [.bottomRight, .bottomLeft], radius: 10)
    }

    func navigationBarSelectIndex(type: TabbarType) {
        setupTilteLabel(type: type)
        isHiddenAddButton(type: type)
        setupLayoutView()
    }

    func setupTilteLabel(type: TabbarType) {
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
