//
//  HomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet var navigationBarView: TitleTabBarView!
    @IBOutlet var coinPriceTableView: UITableView!
    @IBOutlet var bottomCoinPriceTableViewLC: NSLayoutConstraint!

    let limit = 10
    var start = 1
    var isLoading = false
    var endLoadMore = false
    var isLoadLogo = false
    let downloader = ImageDownloader()
    var coins: [Coin] = []
    let imageCache = ImageCache.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataAPI()
        setUpTableView()
        navigationBarView.navigationBarSelectIndex(type: .home)
      
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.setupLayout()
        bottomCoinPriceTableViewLC.constant = 80
            .scaleH
    }

    func getDataAPI() {
        if !isLoading && !endLoadMore {
            isLoading = true
            API.request(dataAPI: APICoin.getCoin(start: start, limit: limit)) { (result: ClosureResultCoin<CoinResponse>) in
                switch result {
                case let .success(response):
                    if self.start == 1 {
                        self.coins = response.data
                    } else {
                        self.coins.append(contentsOf: response.data)
                    }
                    if !self.isLoadLogo {
                        self.isLoadLogo = true
                        for index in 0 ..< response.data.count {
                            API.requestLogo(dataAPI: APICoin.getLogo(id: response.data[index].id)) { result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case let .success(data):
                                        response.data[index].logo = data

                                    case let .failure(error):
                                        self.showAlert(title: "Error", message: error.localizedDescription)
                                    case let .disconnected(data):
                                        self.showAlert(title: "Disconnect Logo", message: data)
                                    }
                                }
                            }
                        }
                    }

                    DispatchQueue.main.async {
                        self.coinPriceTableView.reloadData()
                        self.isLoading = false
                        self.isLoadLogo = false
                    }

                case let .failure(error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                case let .disconnected(data):
                    self.showAlert(title: "Disconnect", message: data)
                }
            }
        }
    }

    func setUpTableView() {
        coinPriceTableView.dataSource = self
        coinPriceTableView.delegate = self
        coinPriceTableView.separatorStyle = .none
        coinPriceTableView.register(aClass: CoinPriceCell.self)
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

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(coins[indexPath.row].name)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111.scaleW
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: CoinPriceCell.self, indexPath: indexPath)
        cell.setupData(coin: coins[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if coins.count - 1 == indexPath.row {
            start = isLoading == false ? coins.count + 1 : start
            getDataAPI()
        }
    }
}
