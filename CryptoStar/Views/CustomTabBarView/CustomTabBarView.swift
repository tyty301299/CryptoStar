//
//  CustomTabBarView.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import UIKit
class CustomTabBarView: BaseNibView {
    @IBOutlet var homeView: UIView!
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet var homeImageView: UIImageView!

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet var cornerView: UIView!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var chartsView: UIView!
    @IBOutlet var chartsImageView: UIImageView!
    @IBOutlet var chartsLabel: UILabel!

    @IBOutlet var settingView: UIView!
    @IBOutlet var settingLabel: UILabel!
    @IBOutlet var settingImageView: UIImageView!

    @IBOutlet var tabbarSubViews: [UIView]!
    @IBOutlet var tabbarSubLabels: [UILabel]!

    func setupUI() {
        tabbarSubViews.forEach { $0.frame.size = CGSize(width: 26.scaleW, height: 33.scaleH) }
        tabbarSubLabels.forEach { $0.font = .sfProDisplay(font: .regular, size: 10.scaleW) }
    }

    func tabbarSelectIndex(type: TabbarType) {
        changeLabelTextColor(type: type)
        changeImageView(type: type)
    }

    private func changeLabelTextColor(type: TabbarType) {
        switch type {
        case .home:
            homeLabel.textColor = .black
            chartsLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
            settingLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
        case .chart:
            homeLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
            chartsLabel.textColor = .black
            settingLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
        case .setting:
            homeLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
            chartsLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
            settingLabel.textColor = .black
        }
    }

    private func changeImageView(type: TabbarType) {
        switch type {
        case .home:
            homeImageView.image = UIImage(named: "home_iphone")
            chartsImageView.image = UIImage(named: "charts")
            settingImageView.image = UIImage(named: "setting")
        case .chart:
            homeImageView.image = UIImage(named: "home")
            chartsImageView.image = UIImage(named: "charts_iphone")
            settingImageView.image = UIImage(named: "setting")
        case .setting:
            homeImageView.image = UIImage(named: "home")
            chartsImageView.image = UIImage(named: "charts")
            settingImageView.image = UIImage(named: "setting_iphone")

        }
    }
}


