//
//  SettingViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import UIKit

class SettingViewController: BaseViewController {
    
    @IBOutlet private weak var settingTabelView: UITableView!
    @IBOutlet private weak var navigationBarView: TitleTabBarView!
    
    private let dataSettings: [String] = ["TouchID/FaceID", "Privacy and Policy", "About us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = false
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.setupLayoutView()
    }
    
    func setupNavigationBarView(){
        navigationBarView.navigationBarSelectIndex(type: .home)
        navigationBarView.setupTilteLabel(type: .home)
    }

    func setupTableView() {
        settingTabelView.delegate = self
        settingTabelView.dataSource = self
        settingTabelView.separatorStyle = .none
        settingTabelView.register(aClass: SettingCell.self)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushViewController(CreatePINViewController())
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61.scaleW
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSettings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: SettingCell.self, indexPath: indexPath)
        cell.setupData(data: dataSettings[indexPath.row], index: indexPath.row)
        return cell
    }
}

