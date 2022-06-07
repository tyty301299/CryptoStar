//
//  TokenViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 02/06/2022.
//

import CoreData
import UIKit

class TokenViewController: BaseViewController {
    @IBOutlet private var coinPriceTableView: UITableView!
    @IBOutlet private var navigationBarView: CustomNavigationBarView!

    private let limit = 10
    private var start = 1
    private var coins: [Coin] = []
    private var isLoading = false
    private var isLoadLogo = false
    private var endLoadMore = false
    private var coinEntities = [CoinEntity]()
    private let downloader = ImageDownloader()
    private let imageCache = ImageCache.shared

    override func viewDidLoad() {
        super.viewDidLoad()
      
        getDataFromAPI()
        getAllCoreData()
        setupTableView()
        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: .token,
                               notificationTitle: .isEmptyData)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = true
        }
    }

    func deleteAllCoreData() {
        CoreDataManager.deleteCoreData(name: entityData.coinEntity.getTitle()) { (result: ClosureResult<String>) in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                self.showAlert(title: .errorTextField, message: error.localizedDescription)
            }
        }
    }

    func getAllCoreData() {
        CoreDataManager.getAllCoreData(name: entityData.coinEntity.getTitle(),
                                       id: entityData.id.getTitle()) { (result: ClosureResultCoreData) in
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    self.coinEntities = data
                    self.coinPriceTableView.reloadData()
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

    func updateDataSwitch(coin: CoinEntity, valueSwitch: Bool) {
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

    func updateDataLogo(coin: Coin) {
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

    func getDataFromAPI() {
        if !isLoading {
            isLoading = true
            start = coinEntities.count + 1
            API.request(dataAPI: APICoin.getCoin(start: start, limit: limit)) { (result: ClosureResultCoin<CoinResponse>) in
                switch result {
                case let .success(response):
                    guard let data = response.data else {
                        return
                    }
                    self.coins.removeAll()
                    self.coins.append(contentsOf: data)
                    self.saveContext(coin: data)
                    self.getLogo(coins: data)

                case let .failure(error):
                    self.showAlert(title: .errorTextField, message: error.localizedDescription)
                case let .disconnected(data):
                    self.showAlert(title: .disconnected, message: data)
                    self.isLoading = false
                }
            }
        }
    }

    // MARK:

    func getLogo(coins: [Coin]) {
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
        isLoading = false
        DispatchQueue.main.async {
            self.coinPriceTableView.reloadData()
        }
    }

    func setupTableView() {
        coinPriceTableView.dataSource = self
        coinPriceTableView.delegate = self
        coinPriceTableView.separatorStyle = .none
        coinPriceTableView.register(aClass: CoinPriceCell.self)
    }
}

extension TokenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension TokenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111.scaleW
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinEntities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: CoinPriceCell.self, indexPath: indexPath)
        cell.setupDataLocal(coin: coinEntities[indexPath.row])
        cell.delegateCell = self

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Loading more : \(coinEntities.count)")
        if coinEntities.count - 1 == indexPath.row && !isLoading {
           
            getDataFromAPI()
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
