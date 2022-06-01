//
//  CoinPriceCell.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 25/05/2022.
//

import UIKit

class CoinPriceCell: UITableViewCell {
    @IBOutlet var percentOfCoinLabel: UILabel!
    @IBOutlet var statusCoinImageView: UIImageView!
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
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLabel()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
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

    private func setUpLabel() {
        nameLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)
        symbolLabel.font = .sfProDisplay(font: .regular, size: 10.scaleW)
        symbolLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
        priceUSDLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)
        percentOfCoinLabel.font = .sfProDisplay(font: .regular, size: 10.scaleW)
    }

    func setupData(coin: Coin) {
        self.coin = coin
        nameLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceUSDLabel.text = coin.priceUSD
        setPercentChange(price: coin.quote.USD.percentChange24H)
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
}
