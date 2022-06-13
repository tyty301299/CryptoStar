//
//  SettingViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import FirebaseAuth
import UIKit

class SettingViewController: BaseViewController {
    @IBOutlet private var settingTabelView: UITableView!
    @IBOutlet private var navigationBarView: TitleTabBarView!
    var isLoading = false
    var titleNavigations: [TitleNavigationBar] = [.isEmptyData, .privacyAndPolicy, .aboutUs]
    private var titleSettings = ["TouchID/FaceID", "Privacy and Policy", "About us", "Log out"]
    var refresh = ATRefreshControl(frame: CGRect(x: 0, y: -50.scaleW,
                                                 width: kScreen.width, height: 50.scaleW))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControlTableView()
        navigationBarView.navigationBarSelectIndex(type: .setting)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = false
            tabbarController.containerTabBarView.isHidden = false
            tabbarController.shadowTabbarView.isHidden = false
        }
        settingTabelView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.setupCornerRadius()
        navigationBarView.setupLayoutView()
    }

    func setupRefreshControlTableView() {
        if !isLoading {
            refresh.addTarget(self,
                              action: #selector(actionReloadDataTableView),
                              for: .valueChanged)
        }
    }

    @objc func actionReloadDataTableView() {
        settingTabelView.reloadData()
        settingTabelView.refreshControl?.endRefreshing()
    }

    func setupNavigationBarView() {
        navigationBarView.navigationBarSelectIndex(type: .setting)
    }

    func setupTableView() {
        settingTabelView.delegate = self
        settingTabelView.dataSource = self
        settingTabelView.addSubview(refresh)
        settingTabelView.separatorStyle = .none
        settingTabelView.register(aClass: SettingCell.self)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == titleSettings.count - 1 {
            print("Log out")
            showAlertLogout()
        } else if indexPath.row != 0 {
            let webView = WebViewController()
            webView.titleNavigation = titleNavigations[indexPath.row]
            pushViewController(webView)
        }
    }

    func showAlertLogout() {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to sign out ?", preferredStyle: .actionSheet)

        let settingsAction = UIAlertAction(title: "Sign out", style: .destructive) { (_) -> Void in
            try? Auth.auth().signOut()
            KeyChainManager.shared.deletePinCode(pinCode: "")
            UserDefaultUtils.isFaceID = false
            self.appDelegate.setWelcomeViewController()
        }

        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61.scaleW
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleSettings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: SettingCell.self, indexPath: indexPath)
        cell.setupData(data: titleSettings[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension SettingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refresh.containingScrollViewDidEndDragging(scrollView)
    }

    func SettingViewController(_ scrollView: UIScrollView) {
        print("Scroll View Y:\(scrollView.contentOffset.y)")
        refresh.didScroll(scrollView)
    }
}

extension SettingViewController: SettingCellDelegate {
    func faceIDSwitchChanged(sender: SettingCell, onChanged: Bool) {
        let pinViewController = CreatePinViewController()
        pinViewController.isCheckFaceID = onChanged
        pushViewController(pinViewController)
    }
}
