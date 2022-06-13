//
//  CoinPriceCell.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 25/05/2022.
//

import UIKit

protocol CoinPriceCellDelegate: class {
    func coinSwitchChanged(sender: CoinPriceCell, onSwitch: Bool)
}

class CoinPriceCell: UITableViewCell {
    weak var delegate: CoinPriceCellDelegate?

    @IBOutlet var percentOfCoinLabel: UILabel!
    @IBOutlet var statusCoinImageView: UIImageView!
    @IBOutlet var chartSwitch: UISwitch!
    @IBOutlet var priceUSDLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var containerCoinView: UIView!

    @IBOutlet var traillingStatusCoinImageViewLC: NSLayoutConstraint!
    @IBOutlet var bottomStatusCoinImageViewLC: NSLayoutConstraint!
    @IBOutlet var bottomPriceUSDLabelLC: NSLayoutConstraint!
    @IBOutlet var trailingPriceUSDLabelLC: NSLayoutConstraint!
    @IBOutlet var spaceIconImageViewAndSymbolLabelLC: NSLayoutConstraint!
    @IBOutlet var topSymbolLabelLC: NSLayoutConstraint!
    @IBOutlet var leadingIconImageViewLC: NSLayoutConstraint!
    @IBOutlet var topIconImageViewLC: NSLayoutConstraint!
    @IBOutlet var leadingNameLabelLC: NSLayoutConstraint!
    @IBOutlet var topNameLabelLC: NSLayoutConstraint!
    @IBOutlet var topStatusCoinViewLC: NSLayoutConstraint!
    @IBOutlet var trailingStatusCoinViewLC: NSLayoutConstraint!

    private var coin: Coin?
    var coinEntity: CoinEntity?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabel()
        setupLayoutViews()
    }

    @IBAction func actionSwitch(_ sender: Any) {
        delegate?.coinSwitchChanged(sender: self, onSwitch: chartSwitch.isOn)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setupLayoutViews() {
        containerCoinView.setCornerRadius(cornerRadius: 10)
        topSymbolLabelLC.constant = 17.scaleH
        trailingStatusCoinViewLC.constant = 21.scaleW
        bottomPriceUSDLabelLC.constant = 3.scaleH
        trailingPriceUSDLabelLC.constant = 4.scaleW
        bottomStatusCoinImageViewLC.constant = 5.5.scaleH
        traillingStatusCoinImageViewLC.constant = 10.scaleH
        topNameLabelLC.constant = 17.scaleH
        leadingNameLabelLC.constant = 20.scaleW
        topIconImageViewLC.constant = 13.5.scaleH
        leadingIconImageViewLC.constant = 20.scaleW
        topSymbolLabelLC.constant = 15.scaleH
        spaceIconImageViewAndSymbolLabelLC.constant = 5.5.scaleW
    }

    func setChartSwitch(_ check: Bool = true) {
        chartSwitch.isHidden = check
    }

    private func setupLabel() {
        nameLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)
        symbolLabel.font = .sfProDisplay(font: .regular, size: 10.scaleW)
        symbolLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
        priceUSDLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)
        percentOfCoinLabel.font = .sfProDisplay(font: .regular, size: 10.scaleW)
    }

    // MARK: DATA SCREEN TOKEN VIEW CONTROLLER GET DATA CORE DATA

    func setupDataLocal(coin: CoinEntity) {
        coinEntity = coin
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceUSDLabel.text = coin.priceUSD
        chartSwitch.isOn = coin.checkSwitch
        iconImageView.image = UIImage(named: "cryptoStar")
        if let logoUrl = coin.logo {
            if logoUrl.contains("http") {
                iconImageView?.load(link: logoUrl)
            }

        } else {
        }

        percentOfCoinLabel.isHidden = true
        statusCoinImageView.isHidden = true
    }

    func updateDataLogo(coin: Coin) {
        CoreDataManager.updateLogo(coin: coin) { (result: ClosureResult<String>) in
            switch result {
            case .success:
                break
            case let .failure(error):
                UIApplication.topViewController()?.showAlert(title: .errorUpdateCoreData,
                                                             message: error.localizedDescription)
            }
        }
    }

    func updateDataLogoFromLocal(coin: CoinEntity) {
        var convertCoin: Coin?
        var price = coin.priceUSD
        price?.removeLast()
        convertCoin?.id = Int(coin.id)
        convertCoin?.logo = coin.logo
        convertCoin?.symbol = coin.symbol ?? ""
        convertCoin?.quote.USD.price = Double(price ?? "0") ?? 0
        convertCoin?.checkSwitch = coin.checkSwitch
        guard let data = convertCoin else {
            return
        }
        CoreDataManager.updateLogo(coin: data) { (result: ClosureResult<String>) in
            switch result {
            case .success:
                break
            case let .failure(error):
                UIApplication.topViewController()?.showAlert(title: .errorUpdateCoreData,
                                                             message: error.localizedDescription)
            }
        }
    }

    // MARK: - - DATA SCREEN HOME VIEW CONTROLLER GET API

    func setupData(coin: Coin) {
        self.coin = coin
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceUSDLabel.text = coin.priceUSD
        setPercentChange(price: coin.quote.USD.percentChange24H)
        setChartSwitch()
        if let logoUrl = coin.logo {
            iconImageView?.load(link: logoUrl)
        }
        coin.getLogoClosure = { [weak self] in
            self?.iconImageView?.load(link: coin.logo ?? "")
        }
    }

    func setPercentChange(price: Double) {
        let status = price > 0 ? StatusCoin.up : StatusCoin.down
        statusCoinImageView.image = status.iconImage
        percentOfCoinLabel.textColor = status.textColor
        var percentCoin = "\(price.subString)%"
        if percentCoin[percentCoin.startIndex] == "-" {
            percentCoin.remove(at: percentCoin.startIndex)
        }

        percentOfCoinLabel.text = percentCoin
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        coin?.getLogoClosure = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: true)
    }
}
