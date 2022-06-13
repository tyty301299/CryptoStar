//
//  HomeViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import Network
import UIKit
let kScreen = UIScreen.main.bounds

class HomeViewController: BaseViewController {
    @IBOutlet private var navigationBarView: TitleTabBarView!
    @IBOutlet private var coinPriceTableView: UITableView!
    var refresh = ATRefreshControl(frame: CGRect(x: 0, y: -50.scaleW,
                                                 width: kScreen.width,
                                                 height: 50.scaleW))
    lazy var refreshLoadMore: ATRefreshControl = {
        let refresh = ATRefreshControl(frame: CGRect(x: 0, y: kScreen.height - 20.scaleW,
                                                     width: kScreen.width,
                                                     height: 50.scaleW))
        refresh.backgroundColor = UIColor.clear
        return refresh
    }()

    @IBOutlet private var bottomCoinPriceTableViewLC: NSLayoutConstraint!
    private let limit = 10
    private var start = 1
    private var isLoading = false
    private let downloader = ImageDownloader()
    private var coins: [Coin] = []
    private let imageCache = ImageCache.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        getDataAPI()
        setupTableView()
        setupRefreshControlTableView()
        setupNavigationBarView()
        navigationBarView.navigationBarSelectIndex(type: .home)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        navigationBarView.setupCornerRadius()
        navigationBarView.setupLayoutView()
    }

    func setupRefreshControlTableView() {
        if !isLoading {
            refresh.addTarget(self, action: #selector(actionReloadDataTableView), for: .valueChanged)
        }
    }

    @objc func actionReloadDataTableView() {
        isLoading = false
        start = 1
        ImageCache.shared.removeAll()
        getDataAPI()
        coinPriceTableView.reloadData()
        coinPriceTableView.refreshControl?.endRefreshing()
    }

    func setupNavigationBarView() {
        navigationBarView.navigationBarSelectIndex(type: .home)
        navigationBarView.setupTitleLabel(type: .home)
    }

    func getDataAPI() {
        print("Get API")
        if !isLoading {
            isLoading = true
            start = coins.isEmpty ? 1 : coins.count + 1
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
                    self.setTimerDelayAPI(timer: 10)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + timer) {
            self.start = self.coins.count + 1
            self.getDataAPI()
        }
    }

    func setupTableView() {
        bottomCoinPriceTableViewLC.constant = 80.scaleW
        coinPriceTableView.dataSource = self
        coinPriceTableView.delegate = self
        coinPriceTableView.addSubview(refresh)
        coinPriceTableView.addSubview(refreshLoadMore)
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

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refresh.containingScrollViewDidEndDragging(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll View Y:\(scrollView.contentOffset.y)")
        refresh.didScroll(scrollView)
        refreshLoadMore.didScrollDown(scrollView)
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
            if isLoading == false {
                refreshLoadMore.showLoadMore(tableView)
                setTimerLoadMore(timer: 3)
            }
        }
    }
}
