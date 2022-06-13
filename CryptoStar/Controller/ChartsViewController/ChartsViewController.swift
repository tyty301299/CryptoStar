//
//  ChartsViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 24/05/2022.
//

import CoreData
import UIKit

class ChartsViewController: BaseViewController {
    @IBOutlet private var chartCoinTableView: UITableView!
    @IBOutlet private var navigationBarView: TitleTabBarView!
    var refresh = ATRefreshControl(frame: CGRect(x: 0, y: -50.scaleW,
                                                 width: kScreen.width, height: 50.scaleW))
    private var coinChartEntities: [CoinEntity] = []
    private var isloading = false
    private let context = AppDelegate.shared.persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupRefreshControlTableView()
        setupNavigationBarView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = false
            tabbarController.containerTabBarView.isHidden = false
            tabbarController.shadowTabbarView.isHidden = false
        }
        getSelectedDataFromCoreData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        navigationBarView.setupCornerRadius()
        navigationBarView.setupLayoutView()
    }

    func setupImageBackGround(datas: [CoinEntity]) {
        if datas.isEmpty {
            chartCoinTableView.backgroundView = UIImageView(image: UIImage(named: "cryptoStar"))
            chartCoinTableView.backgroundView?.contentMode = .scaleAspectFit
        } else {
            chartCoinTableView.backgroundView?.isHidden = true
        }
    }

    func setupRefreshControlTableView() {
        if !isloading {
            refresh.addTarget(self, action: #selector(actionReloadDataTableView), for: .valueChanged)
        }
    }

    @objc func actionReloadDataTableView() {
        coinChartEntities.removeAll()
        getSelectedDataFromCoreData()
        chartCoinTableView.reloadData()
        chartCoinTableView.refreshControl?.endRefreshing()
    }

    func getSelectedDataFromCoreData() {
        isloading = true
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoinEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "checkSwitch = \(true)")

        do {
            coinChartEntities = try context.fetch(fetchRequest) as! [CoinEntity]
            DispatchQueue.main.async {
                self.isloading = false
                self.chartCoinTableView.reloadData()
            }
        } catch let error as NSError {
            self.showAlert(title: .errorTextField,
                           message: error.localizedDescription)
        }
    }

    func setupTableView() {
        chartCoinTableView.dataSource = self
        chartCoinTableView.delegate = self
        chartCoinTableView.addSubview(refresh)
        chartCoinTableView.separatorStyle = .none
        chartCoinTableView.register(aClass: ChartsCoinCell.self)
    }

    func setupNavigationBarView() {
        navigationBarView.navigationBarSelectIndex(type: .chart)
        navigationBarView.addButton.addTarget(self,
                                              action: #selector(actionAddChartCoin),
                                              for: .touchUpInside)
    }

    @objc func actionAddChartCoin() {
        var tokenView = TokenViewController()
        pushViewController(tokenView)
    }
}

extension ChartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ChartsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.scaleW
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setupImageBackGround(datas: coinChartEntities)
        return coinChartEntities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: ChartsCoinCell.self,
                                         indexPath: indexPath)

        cell.setupDataLocal(coin: coinChartEntities[indexPath.row])
        return cell
    }
}

extension ChartsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refresh.containingScrollViewDidEndDragging(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll View Y:\(scrollView.contentOffset.y)")
        refresh.didScroll(scrollView)
    }
}
