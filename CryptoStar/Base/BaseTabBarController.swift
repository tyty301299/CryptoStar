//
//  BaseTabBarController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

<<<<<<< Updated upstream
class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    var customTabBarView = CustomTabBarView()
    var navigationBarView = TitleTabBarView()
    var tabBarViewController = [HomeViewController(), ChartsViewController(), SettingViewController()]
=======
class BaseTabBarController: UITabBarController {
    var tabBarView = UIView()

    private var homeItem = ItemTabBarView(with: .home, index: 0)
    private var chartItem = ItemTabBarView(with: .chart, index: 1)
    private var settingItem = ItemTabBarView(with: .setting, index: 2)
>>>>>>> Stashed changes

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupAnimationForItemView(withIndex: homeItem.item)
        binding()
    }

    func setupViews() {
        tabBar.isHidden = true
<<<<<<< Updated upstream
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
=======
        tabBarView.backgroundColor = .white
        let tabbarItems = [homeItem, chartItem, settingItem]
        viewControllers = tabbarItems.map({ $0.item.viewController })
        view.addSubview(tabBarView)

        tabbarItems.forEach {
            tabBarView.addSubview($0)
        }
>>>>>>> Stashed changes
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
<<<<<<< Updated upstream
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
=======
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
            homeItem.heightAnchor.constraint(equalToConstant: 33.scaleH),
            homeItem.widthAnchor.constraint(greaterThanOrEqualToConstant: 26.scaleW),
        ]
        NSLayoutConstraint.activate(constaintshomeItem)

        chartItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintschartItem = [
            chartItem.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor),
            chartItem.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 20.scaleW),
            chartItem.heightAnchor.constraint(equalToConstant: 33.scaleH),
            chartItem.widthAnchor.constraint(greaterThanOrEqualToConstant: 28.scaleW),
        ]

        NSLayoutConstraint.activate(constaintschartItem)

        settingItem.translatesAutoresizingMaskIntoConstraints = false
        let constaintsfavoriteItem = [
            settingItem.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -43.scaleW),
            settingItem.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 20.scaleW),
            settingItem.heightAnchor.constraint(equalToConstant: 33.scaleH),
            settingItem.widthAnchor.constraint(greaterThanOrEqualToConstant: 26.scaleW),
            // settingItem.widthAnchor.constraint(equalToConstant: 28.scaleW),
        ]
        NSLayoutConstraint.activate(constaintsfavoriteItem)
>>>>>>> Stashed changes
    }
}
