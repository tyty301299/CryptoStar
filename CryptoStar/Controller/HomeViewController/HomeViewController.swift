//
//  HomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var navigationBarView: TitleTabBarView!
    @IBOutlet private var coinPriceTableView: UITableView!

    @IBOutlet private var bottomCoinPriceTableViewLC: NSLayoutConstraint!
    private let limit = 10
    private var start = 1
    private var isLoading = false
    private var endLoadMore = false
    private var isLoadLogo = false
    private let downloader = ImageDownloader()
    private var coins: [Coin] = []
    private var errorMessage = ""
    private let imageCache = ImageCache.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
        setupRefreshControlTableView()
        getDataAPI()
        setupTableView()
        setupNavigationBarView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.setupLayoutView()
        bottomCoinPriceTableViewLC.constant = 80.scaleW
    }

    func setupRefreshControlTableView() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        coinPriceTableView.refreshControl = refreshControl
    }

    @objc func reloadTableView() {
        isLoading = false
        start = 1
        coins.removeAll()
        ImageCache.shared.removeAll()
        getDataAPI()
        coinPriceTableView.reloadData()
        coinPriceTableView.refreshControl?.endRefreshing()
    }

    func setupActivityIndicatorView() {
        activityIndicator.center = view.center
        activityIndicator.frame.size.height = 100
        activityIndicator.frame.size.width = 100
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.red
        view.addSubview(activityIndicator)
    }

    func setupNavigationBarView() {
        navigationBarView.navigationBarSelectIndex(type: .home)
        navigationBarView.setupTilteLabel(type: .home)
    }

    func getDataAPI() {
        if !isLoading {
            isLoading = true
            start = coins.isEmpty ? 1 : coins.count + 1

            API.request(dataAPI: APICoin.getCoin(start: start, limit: limit)) { (result: ClosureResultCoin<CoinResponse>) in
                switch result {
                case let .success(response):
                    if let errorMessage = response.status.errorMessage {
                        self.showAlert(title: .errorMessage, message: errorMessage)
                    } else {
                        guard let data = response.data else {
                            return
                        }

                        DispatchQueue.main.async {
                            self.coins.append(contentsOf: data)
                            self.getLogo(coins: data)
                            self.isLoading = false
                            self.coinPriceTableView.reloadData()
                        }
                    }

                case let .failure(error):
                    self.showAlert(title: .errorTextField, message: error.localizedDescription)
                case let .disconnected(data):
                    self.showAlert(title: .errorMessage, message: data)
                    self.setTimerDelayAPI(timer: 3)
                }
            }
        }
    }

    func getLogo(coins: [Coin]) {
        for index in 0 ..< coins.count {
            API.requestLogo(dataAPI: APICoin.getLogo(id: coins[index].id)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(data):
                        coins[index].logo = data
                    case let .failure(error):
                        self.showAlert(title: .errorTextField, message: error.localizedDescription)
                    case let .disconnected(data):
                        self.setTimerDelayAPI(timer: 3)
                    }
                }
            }
        }
    }

    func setTimerDelayAPI(timer: Double) {
        Timer.scheduledTimer(withTimeInterval: timer, repeats: false) { _ in
            self.isLoading = false
        }
    }

    func setTimerLoadMore(timer: Double) {
        Timer.scheduledTimer(withTimeInterval: timer, repeats: false) { _ in
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.stopAnimating()
            self.start = self.coins.count + 1
            self.getDataAPI()
        }
    }

    func setupTableView() {
        coinPriceTableView.dataSource = self
        coinPriceTableView.delegate = self
        coinPriceTableView.separatorStyle = .none
        coinPriceTableView.register(aClass: CoinPriceCell.self)
    }

    func setupLayoutNavigationBar() {
        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
        let constaints = [
            navigationBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
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
            activityIndicator.hidesWhenStopped = false
            activityIndicator.startAnimating()
            if isLoading == false {
                setTimerLoadMore(timer: 2)
            }
        }
    }
}
