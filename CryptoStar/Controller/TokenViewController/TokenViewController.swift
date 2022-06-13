//
//  TokenViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 02/06/2022.
//

import CoreData
import FirebaseAuth
import UIKit

class TokenViewController: BaseViewController {
    @IBOutlet private var coinPriceTableView: UITableView!
    @IBOutlet private var navigationBarView: CustomNavigationBarView!
    var refresh = ATRefreshControl(frame: CGRect(x: 0, y: -50.scaleW,
                                                 width: kScreen.width, height: 50.scaleW))
    var refreshLoadMore = ATRefreshControl(frame: CGRect(x: 0, y: kScreen.height - 20.scaleW,
                                                         width: kScreen.width, height: 50.scaleW))
    private let limit = 10
    private var start: Int = 1
    private var coins: [Coin] = []
    private var isLoading = false
    private var loadingLogo = false
    private var coinEntities: [CoinEntity] = []
    private let downloader = ImageDownloader()
    private let imageCache = ImageCache.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRefreshControlTableView()
        setupTableView()
        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: .token)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllCoreData()
        if coinEntities.isEmpty {
            getDataFromAPI()
            getAllCoreData()
        }
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = true
            tabbarController.containerTabBarView.isHidden = true
            tabbarController.shadowTabbarView.isHidden = true
        }
    }

    private func upLoadLogoCoreData(coin: [CoinEntity]) {
        coin.forEach { result in
            if result.logo == nil {
                API.requestLogo(dataAPI: APICoin.getLogo(id: Int(result.id))) { logo in
                    switch logo {
                    case let .success(data):
                        result.logo = data
                    case let .failure(error):
                        self.showAlert(title: .errorTextField, message: error.localizedDescription)
                    case let .disconnected(data):
                        self.showAlert(title: .logo, message: data)
                    }
                }
            }
        }
    }

    private func setTimerLoadMore(timer: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timer) {
            self.start = self.coinEntities.count + 1
            print("Count LoadMore :\(self.start)")
            self.getDataFromAPI()
        }
    }

    private func setupRefreshControlTableView() {
        if !isLoading {
            refresh.addTarget(self, action: #selector(actionReloadDataTableView), for: .valueChanged)
        }
    }

    @objc func actionReloadDataTableView() {
        isLoading = false
        loadingLogo = false
        start = 1
        coinEntities.removeAll()
        coins.removeAll()
        getAllCoreData()
        coinPriceTableView.reloadData()
        coinPriceTableView.refreshControl?.endRefreshing()
    }

    private func deleteAllCoreData() {
        CoreDataManager.deleteCoreData(name: entityData.coinEntity.getTitle()) { (result: ClosureResult<String>) in
            switch result {
            case let .success(data):
                print("Data :\(self.coinEntities.isEmpty)")
            case let .failure(error):
                self.showAlert(title: .errorTextField, message: error.localizedDescription)
            }
        }
    }

    private func getAllCoreData() {
        CoreDataManager.getAllCoreData(name: entityData.coinEntity.getTitle(),
                                       id: entityData.id.getTitle()) { (result: ClosureResultCoreData) in
            switch result {
            case let .success(data):
                self.coinEntities = data
                print("Coin Entities : \(data.isEmpty)")
                if data.isEmpty {
                    self.start = 1
                    self.getDataFromAPI()
                } else {
                    self.upLoadLogoCoreData(coin: self.coinEntities)
                    self.start = data.count + 1
                }
            case let .failure(error):
                self.showAlert(title: .errorTextField, message: error.localizedDescription)
            case let .disconnected(data):
                self.showAlert(title: .disconnected, message: data)
            }
        }
    }

    func saveContext(coin: [Coin]) {
        CoreDataManager.saveData(dataCoin: coin) { (result: ClosureResult<String>) in
            switch result {
            case .success:
                self.getAllCoreData()
            case let .failure(error):
                self.showAlert(title: .errorTextField, message: error.localizedDescription)
            }
        }
    }

    private func updateDataSwitch(coin: CoinEntity, valueSwitch: Bool) {
        CoreDataManager.updateDataSwitch(coin: coin, valueSwitch: valueSwitch) { (result: ClosureResult<String>) in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.showAlert(title: .errorUpdateCoreData,
                               message: error.localizedDescription)
            }
        }
    }

    private func updateDataLogo(coin: Coin) {
        CoreDataManager.updateLogo(coin: coin) { (result: ClosureResult<String>) in
            switch result {
            case .success:
                break
            case let .failure(error):
                self.showAlert(title: .errorUpdateCoreData,
                               message: error.localizedDescription)
            }
        }
    }

    private func getDataFromAPI() {
        if !isLoading {
            isLoading = true
            start = coinEntities.isEmpty ? 1 : coinEntities.count + 1

            API.request(dataAPI: APICoin.getCoin(start: start, limit: limit)) { (result: ClosureResultCoin<CoinResponse>) in
                switch result {
                case let .success(response):
                    self.refreshLoadMore.hideLoadMore(self.coinPriceTableView)
                    if let errorMessage = response.status.errorMessage {
                        self.showAlert(title: .errorMessage, message: errorMessage)
                    } else {
                        guard let data = response.data else {
                            return
                        }

                        DispatchQueue.main.async {
                            self.saveContext(coin: data)
                            self.getLogo(coins: data)
                            self.isLoading = false
                        }
                    }

                case let .failure(error):
                    self.showAlert(title: .errorTextField, message: error.localizedDescription)
                case let .disconnected(data):
                    self.showAlert(title: .errorMessage, message: data)
                    self.setTimerDelayAPI(timer: 10)
                }
            }
        }
    }

    private func setTimerDelayAPI(timer: Double) {
        Timer.scheduledTimer(withTimeInterval: timer, repeats: false) { _ in
            self.isLoading = false
            self.loadingLogo = false
        }
    }

    private func getLogo(coins: [Coin]) {
        loadingLogo = true
        for index in 0 ..< coins.count {
            API.requestLogo(dataAPI: APICoin.getLogo(id: coins[index].id)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(data):
                        coins[index].logo = data
                        self.updateDataLogo(coin: coins[index])
                    case let .failure(error):
                        self.showAlert(title: .errorTextField, message: error.localizedDescription)
                    case let .disconnected(data):
                        self.showAlert(title: .logo, message: data)
                    }
                }
            }
        }

        DispatchQueue.main.async {
            self.isLoading = false
            self.loadingLogo = false
            self.coinPriceTableView.reloadData()
        }
    }

    private func setupTableView() {
        coinPriceTableView.dataSource = self
        coinPriceTableView.delegate = self
        coinPriceTableView.addSubview(refresh)
        coinPriceTableView.addSubview(refreshLoadMore)
        coinPriceTableView.separatorStyle = .none
        coinPriceTableView.register(aClass: CoinPriceCell.self)
    }
}

extension TokenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Data Table View Cell : \(coinEntities[indexPath.row].logo)")
    }
}

extension TokenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111.scaleW
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinEntities.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: CoinPriceCell.self, indexPath: indexPath)
        cell.setupDataLocal(coin: coinEntities[indexPath.row])
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if coinEntities.count - 1 == indexPath.row {
            if isLoading == false && loadingLogo == false {
                print("Loading more : \(coinEntities.count)")
                refreshLoadMore.showLoadMore(tableView)
                setTimerLoadMore(timer: 3)
            } else {
                setTimerDelayAPI(timer: 10)
            }
        }
    }
}

extension TokenViewController: CoinPriceCellDelegate {
    func coinSwitchChanged(sender: CoinPriceCell, onSwitch: Bool) {
        guard let data = sender.coinEntity else {
            return
        }
        updateDataSwitch(coin: data, valueSwitch: onSwitch)
    }
}

extension TokenViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refresh.containingScrollViewDidEndDragging(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll View :\(scrollView.contentOffset.y)")
        if !coinEntities.isEmpty {
            refreshLoadMore.didScrollDown(scrollView)
        }
        refresh.didScroll(scrollView)
    }
}
