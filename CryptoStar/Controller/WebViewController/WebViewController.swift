//
//  WebViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 09/06/2022.
//

import UIKit
import WebKit
class WebViewController: BaseViewController {
    @IBOutlet var webSettingView: WKWebView!
    @IBOutlet var navigationBarView: CustomNavigationBarView!
    var titleNavigation: TitleNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: titleNavigation)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = true
            tabbarController.containerTabBarView.isHidden = true
            tabbarController.shadowTabbarView.isHidden = true
        }
    }

    func setupWebView() {
        guard let url = URL(string: titleNavigation.url) else {
            return
        }
        webSettingView.load(URLRequest(url: url))
    }
}
