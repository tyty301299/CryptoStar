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

    private var coinChartEntities = [CoinEntity]()
    private let context = AppDelegate.shared.persistentContainer.viewContext

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
        getSelectedDataCoreData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarView.setupLayoutView()
    }

    func getSelectedDataCoreData() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoinEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "checkSwitch = \(true)")

        do {
            coinChartEntities = try context.fetch(fetchRequest) as! [CoinEntity]
            DispatchQueue.main.async {
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
        chartCoinTableView.separatorStyle = .none
        chartCoinTableView.register(aClass: ChartsCoinCell.self)
    }

    func setupNavigationBarView() {
        navigationBarView.setupTilteLabel(type: .chart)
        navigationBarView.navigationBarSelectIndex(type: .chart)
        navigationBarView.addButton.addTarget(self,
                                              action: #selector(onClickAddButton),
                                              for: .touchUpInside)
    }

    @objc func onClickAddButton() {
        pushViewController(TokenViewController())
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
        return coinChartEntities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: ChartsCoinCell.self,
                                         indexPath: indexPath)
        cell.setupDataLocal(coin: coinChartEntities[indexPath.row])
        return cell
    }
}
