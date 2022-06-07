//
//  BaseTabBarController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class BaseTabBarController: UITabBarController {
    var customTabBarView = UIView()
    private var homeItem = ItemTabBarView(with: .home, index: 0)
    private var chartItem = ItemTabBarView(with: .chart, index: 1)
    private var settingItem = ItemTabBarView(with: .setting, index: 2)
    override func viewDidLoad() {
        tabBar.isHidden = true
        customTabBarView.backgroundColor = .white
        let Items = [homeItem, chartItem, settingItem]
        let TabBarviewControllers = [homeItem.item.viewController, chartItem.item.viewController, settingItem.item.viewController]
        viewControllers = TabBarviewControllers
        view.addSubview(customTabBarView)
        Items.forEach {
            view.addSubview($0)
        }
        homeItem.isSelected = true
        setupAnimationItemView(index: homeItem.item)
        bind()
      
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customLayoutTabBar()
        customTabBarView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
    }

    func setupAnimationItemView(index: TabItem) {
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

    func bind() {
        let tapHome = UITapGestureRecognizer(target: self, action: #selector(handdingTapTabBarMenu(sender:)))
        let tapChart = UITapGestureRecognizer(target: self, action: #selector(handdingTapTabBarMenu(sender:)))
        let tapSetting = UITapGestureRecognizer(target: self, action: #selector(handdingTapTabBarMenu(sender:)))
        homeItem.addGestureRecognizer(tapHome)
        chartItem.addGestureRecognizer(tapChart)
        settingItem.addGestureRecognizer(tapSetting)
    }

    @objc func handdingTapTabBarMenu(sender: UITapGestureRecognizer) {
        guard let view = sender.view as? ItemTabBarView else { return }
        setupAnimationItemView(index: view.item)
    }

    func customLayoutTabBar() {
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false

        let constaints = [
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            customTabBarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 80 / 812),
        ]
        NSLayoutConstraint.activate(constaints)

       

        homeItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintshomeItem = [
            homeItem.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: 43.scaleW),

            homeItem.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor, constant: -27.scaleH),
            homeItem.heightAnchor.constraint(equalToConstant: 33.scaleH),
            homeItem.widthAnchor.constraint(equalToConstant: 28.scaleW),
        ]
        NSLayoutConstraint.activate(constaintshomeItem)


        chartItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintschartItem = [
            chartItem.centerXAnchor.constraint(equalTo: customTabBarView.centerXAnchor),
            chartItem.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor, constant: -27.scaleH),
            chartItem.heightAnchor.constraint(equalToConstant: 33.scaleH),
            chartItem.widthAnchor.constraint(equalToConstant: 28.scaleW),
        ]
        NSLayoutConstraint.activate(constaintschartItem)

        settingItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintsfavoriteItem = [
            settingItem.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor, constant: -43.scaleW),

            settingItem.bottomAnchor.constraint(equalTo: customTabBarView.bottomAnchor, constant: -27.scaleH),
            settingItem.heightAnchor.constraint(equalToConstant: 33.scaleH),
            settingItem.widthAnchor.constraint(equalToConstant: 28.scaleW),
        ]
        NSLayoutConstraint.activate(constaintsfavoriteItem)
    }
}
