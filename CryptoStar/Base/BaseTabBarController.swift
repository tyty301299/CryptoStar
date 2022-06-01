//
//  BaseTabBarController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    var customTabBarView = CustomTabBarView()
    var navigationBarView = TitleTabBarView()
    var tabBarViewController = [HomeViewController(), ChartsViewController(), SettingViewController()]

    override func viewDidLoad() {
        tabBar.isHidden = true
        delegate = self
       
        view.addSubview(customTabBarView)
        view.addSubview(navigationBarView)
        
        viewControllers = tabBarViewController
       
        navigationBarView.navigationbarSelectIndex(type: .home)

        customTabBarView.setupUI()
        customTabBarView.tabbarSelectIndex(type: .home)

        let taphome = UITapGestureRecognizer(target: self, action: #selector(wasTappedHome(_:)))
        taphome.numberOfTapsRequired = 1
        taphome.numberOfTouchesRequired = 1
        customTabBarView.homeView.addGestureRecognizer(taphome)
        customTabBarView.homeView.isUserInteractionEnabled = true

        let tapcharts = UITapGestureRecognizer(target: self, action: #selector(wasTappedCharts(_:)))
        tapcharts.numberOfTapsRequired = 1
        tapcharts.numberOfTouchesRequired = 1
        customTabBarView.chartsView.addGestureRecognizer(tapcharts)
        customTabBarView.chartsView.isUserInteractionEnabled = true

        let tapsetting = UITapGestureRecognizer(target: self, action: #selector(wasTappedSetting(_:)))
        tapsetting.numberOfTapsRequired = 1
        tapsetting.numberOfTouchesRequired = 1

        customTabBarView.settingView.addGestureRecognizer(tapsetting)
        customTabBarView.settingView.isUserInteractionEnabled = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customLayoutTabBar()
        customLayoutNavigationBar()
        navigationBarView.setupLayout()

        customTabBarView.cornerView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        customTabBarView.shadowView.shadow(offset: CGSize(width: 0, height: -2), cornerRadius: 10)

        navigationBarView.cornerView.roundCorners(corners: [.bottomLeft, .bottomRight],
                                                  radius: 10)
        navigationBarView.shadowView.shadow(offset: CGSize(width: 0, height: 2), cornerRadius: 10)
    }
    
    @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
        
    }

    @objc func wasTappedHome(_ gesture: UITapGestureRecognizer) {
        selectedIndex = 0
        navigationBarView.navigationbarSelectIndex(type: .home)
        customTabBarView.tabbarSelectIndex(type: .home)
    }

    @objc func wasTappedCharts(_ gesture: UITapGestureRecognizer) {
        selectedIndex = 1
        navigationBarView.navigationbarSelectIndex(type: .chart)
        customTabBarView.tabbarSelectIndex(type: .chart)
    }

    @objc func wasTappedSetting(_ gesture: UITapGestureRecognizer) {
        selectedIndex = 2
        navigationBarView.navigationbarSelectIndex(type: .setting)
        customTabBarView.tabbarSelectIndex(type: .setting)
    }

    func customLayoutTabBar() {
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        let constaints = [
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            customTabBarView.heightAnchor.constraint(equalToConstant: 80.scaleH),
        ]

        NSLayoutConstraint.activate(constaints)
    }

    func customLayoutNavigationBar() {
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        let constaints = [
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navigationBarView.heightAnchor.constraint(equalToConstant: 125.scaleH),
        ]

        NSLayoutConstraint.activate(constaints)
    }
}
