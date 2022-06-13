//
//  BaseTabBarController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class BaseTabBarController: UITabBarController {
    var containerTabBarView = UIView()
    var tabBarView = UIView()
    var shadowTabbarView = UIView()
    var isShowLoginFaceID = false
    var index = 0
    private var tabbarItems: [ItemTabBarView] = [ItemTabBarView(with: .home, index: 0),
                                                 ItemTabBarView(with: .chart, index: 1),
                                                 ItemTabBarView(with: .setting, index: 2)]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupAnimationForItemView(withIndex: tabbarItems[0].item)
        binding()
        NotificationCenter.default.addObserver(self, selector: #selector(handleApplicationWillEnterForceGround(notification:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoginFaceIDViewController()
    }

    private func showLoginFaceIDViewController() {
        if UserDefaultUtils.isFaceID && !isShowLoginFaceID {
            isShowLoginFaceID = true
            let loginFaceIDViewController = LoginFaceIDViewController()
            loginFaceIDViewController.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(loginFaceIDViewController, animated: false, completion: nil)
        }
    }

    @objc private func handleApplicationWillEnterForceGround(notification: Notification) {
        isShowLoginFaceID = false
        showLoginFaceIDViewController()
    }

    func setupViews() {
        tabBar.isHidden = true
        tabBarView.backgroundColor = .white
        viewControllers = tabbarItems.map({ $0.item.viewController })
        view.addSubview(containerTabBarView)
        containerTabBarView.addSubview(shadowTabbarView)
        containerTabBarView.addSubview(tabBarView)
        tabbarItems.forEach {
            tabBarView.addSubview($0)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayoutTabBar()
        tabBarView.roundCorners(corners: [.topRight, .topLeft], radius: 10)
        shadowTabbarView.shadow(offset: CGSize(width: 0, height: 0), cornerRadius: 10)
    }

    func setupAnimationForItemView(withIndex index: TabItem) {
        switch index {
        case .home:
            tabbarItems[0].isSelected = true
            tabbarItems[1].isSelected = false
            tabbarItems[2].isSelected = false
            selectedIndex = 0
        case .chart:
            tabbarItems[0].isSelected = false
            tabbarItems[1].isSelected = true
            tabbarItems[2].isSelected = false
            selectedIndex = 1
        case .setting:
            tabbarItems[0].isSelected = false
            tabbarItems[1].isSelected = false
            tabbarItems[2].isSelected = true
            selectedIndex = 2
        }
    }

    func binding() {
        tabbarItems.forEach { result in
            let tap = UITapGestureRecognizer(target: self, action: #selector(handdingTabBarMenu(sender:)))
            result.addGestureRecognizer(tap)
        }
    }

    @objc func handdingTabBarMenu(sender: UITapGestureRecognizer) {
        guard let view = sender.view as? ItemTabBarView else { return }
        setupAnimationForItemView(withIndex: view.item)
    }

    private func setupLayoutTabBar() {
        print("Size TabBar Items : \(tabbarItems.count)")
        containerTabBarView.translatesAutoresizingMaskIntoConstraints = false
        let constaintContainer = [
            containerTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            containerTabBarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 80 / 812),
        ]
        NSLayoutConstraint.activate(constaintContainer)

        shadowTabbarView.translatesAutoresizingMaskIntoConstraints = false
        let constaintShadowTabBar = [
            shadowTabbarView.leadingAnchor.constraint(equalTo: containerTabBarView.leadingAnchor, constant: 0),
            shadowTabbarView.trailingAnchor.constraint(equalTo: containerTabBarView.trailingAnchor, constant: 0),
            shadowTabbarView.bottomAnchor.constraint(equalTo: containerTabBarView.bottomAnchor, constant: 0),
            shadowTabbarView.heightAnchor.constraint(equalTo: containerTabBarView.heightAnchor, constant: 0),
        ]

        NSLayoutConstraint.activate(constaintShadowTabBar)

        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        let constaints = [
            tabBarView.leadingAnchor.constraint(equalTo: containerTabBarView.leadingAnchor, constant: 0),
            tabBarView.trailingAnchor.constraint(equalTo: containerTabBarView.trailingAnchor, constant: 0),
            tabBarView.bottomAnchor.constraint(equalTo: containerTabBarView.bottomAnchor, constant: 0),
            tabBarView.heightAnchor.constraint(equalTo: containerTabBarView.heightAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(constaints)

        tabbarItems[0].translatesAutoresizingMaskIntoConstraints = false
        let constaintshomeItem = [
            tabbarItems[0].leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: 0),
//            tabbarItems[0].topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 0),
            tabbarItems[0].heightAnchor.constraint(equalTo: tabBarView.heightAnchor),
            tabbarItems[0].widthAnchor.constraint(equalTo: tabBarView.widthAnchor, multiplier: 1 / 3),
//            tabbarItems[0].widthAnchor.constraint(greaterThanOrEqualToConstant: 28.scaleW),
        ]
        NSLayoutConstraint.activate(constaintshomeItem)

        tabbarItems[1].translatesAutoresizingMaskIntoConstraints = false
        let constaintschartItem = [
            tabbarItems[1].leadingAnchor.constraint(equalTo: tabbarItems[0].trailingAnchor),
            tabbarItems[1].heightAnchor.constraint(equalTo: tabBarView.heightAnchor),
            tabbarItems[1].widthAnchor.constraint(equalTo: tabBarView.widthAnchor, multiplier: 1 / 3),
        ]

        NSLayoutConstraint.activate(constaintschartItem)

        tabbarItems[2].translatesAutoresizingMaskIntoConstraints = false
        let constaintsfavoriteItem = [
            tabbarItems[2].leadingAnchor.constraint(equalTo: tabbarItems[1].trailingAnchor),
            tabbarItems[2].heightAnchor.constraint(equalTo: tabBarView.heightAnchor),
            tabbarItems[2].widthAnchor.constraint(equalTo: tabBarView.widthAnchor, multiplier: 1 / 3),
        ]
        NSLayoutConstraint.activate(constaintsfavoriteItem)
    }
}
