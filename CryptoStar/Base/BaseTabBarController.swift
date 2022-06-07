//
//  BaseTabBarController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class BaseTabBarController: UITabBarController {
    var tabBarView = UIView()

    private var homeItem = ItemTabBarView(with: .home, index: 0)
    private var chartItem = ItemTabBarView(with: .chart, index: 1)
    private var settingItem = ItemTabBarView(with: .setting, index: 2)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupAnimationForItemView(withIndex: homeItem.item)
        binding()
    }

    func setupViews() {
        tabBar.isHidden = true
        tabBarView.backgroundColor = .white
        let tabbarItems = [homeItem, chartItem, settingItem]
        viewControllers = tabbarItems.map({ $0.item.viewController })
        view.addSubview(tabBarView)

        tabbarItems.forEach {
            tabBarView.addSubview($0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayoutTabBar()
        tabBarView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }

    func setupTabBarView(check: Bool) {
        tabBarView.isHidden = check
    }

    func setupAnimationForItemView(withIndex index: TabItem) {
        switch index {
        case .home:
            homeItem.isSelected = true
            chartItem.isSelected = false
            settingItem.isSelected = false
            selectedIndex = 0
        case .chart:
            homeItem.isSelected = false
            chartItem.isSelected = true
            settingItem.isSelected = false
            selectedIndex = 1
        case .setting:
            homeItem.isSelected = false
            chartItem.isSelected = false
            settingItem.isSelected = true
            selectedIndex = 2
        }
    }

    func binding() {
        let tapHomeItem = UITapGestureRecognizer(target: self, action: #selector(handdingTabBarMenu(sender:)))
        let tapChartItem = UITapGestureRecognizer(target: self, action: #selector(handdingTabBarMenu(sender:)))
        let tapSettingItem = UITapGestureRecognizer(target: self, action: #selector(handdingTabBarMenu(sender:)))

        homeItem.addGestureRecognizer(tapHomeItem)
        chartItem.addGestureRecognizer(tapChartItem)
        settingItem.addGestureRecognizer(tapSettingItem)
    }

    @objc func handdingTabBarMenu(sender: UITapGestureRecognizer) {
        guard let view = sender.view as? ItemTabBarView else { return }
        setupAnimationForItemView(withIndex: view.item)
    }

    func setupLayoutTabBar() {
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        let constaints = [
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tabBarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 80 / 812),
        ]
        NSLayoutConstraint.activate(constaints)

        homeItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintshomeItem = [
            homeItem.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 43.scaleW),
            homeItem.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 20.scaleW),
            homeItem.heightAnchor.constraint(equalToConstant: 33.scaleW),
            homeItem.widthAnchor.constraint(greaterThanOrEqualToConstant: 28.scaleW),
        ]
        NSLayoutConstraint.activate(constaintshomeItem)

        chartItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintschartItem = [
            chartItem.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor),
            chartItem.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 20.scaleW),
            chartItem.heightAnchor.constraint(equalToConstant: 33.scaleW),
            chartItem.widthAnchor.constraint(greaterThanOrEqualToConstant: 28.scaleW),
        ]

        NSLayoutConstraint.activate(constaintschartItem)

        settingItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintsfavoriteItem = [
            settingItem.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -43.scaleW),
            settingItem.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 20.scaleW),
            settingItem.heightAnchor.constraint(equalToConstant: 33.scaleW),
            settingItem.widthAnchor.constraint(greaterThanOrEqualToConstant: 28.scaleW),
        ]
        NSLayoutConstraint.activate(constaintsfavoriteItem)
    }
}

