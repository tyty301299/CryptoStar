//
//  ChartsCoinCell.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 03/06/2022.
//

import UIKit

class ChartsCoinCell: UITableViewCell {
    @IBOutlet var dataChartView: UIView!
    @IBOutlet var containerChartView: UIView!
    @IBOutlet var chartView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var nameCoinLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var leadingNameCoinLabelLC: NSLayoutConstraint!

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet var trailingPriceLabelLC: NSLayoutConstraint!
    @IBOutlet var topPriceLabelLC: NSLayoutConstraint!
    @IBOutlet var leadingSymbolLabelLC: NSLayoutConstraint!
    @IBOutlet var topSymbolLabelLC: NSLayoutConstraint!
    @IBOutlet var topLogoImageViewLC: NSLayoutConstraint!
    @IBOutlet var topNameCoinLabelLC: NSLayoutConstraint!
    @IBOutlet var symbolLabel: UILabel!
    private var colorLine: UIColor = .randomColor(alpha: 0.3)
    private var datas: [DataDrawLine] = []
    private var points: [CGPoint] = []
    private var coinEntity: CoinEntity?
    private var usd: Double = 35000.0
    private var width: CGFloat {
        return chartView.bounds.width
    }

    private var height: CGFloat {
        return chartView.bounds.height
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLabel()
        randomData(usdMax: usd)
        print("awakeFromNib : \(datas)")
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print("Chart : \(chartView.frame.size.height)")
        chartView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        drawChartsView()
        setupLayoutViews()
    }

    private func setUpLabel() {
        nameCoinLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)
        symbolLabel.font = .sfProDisplay(font: .regular, size: 10.scaleW)
        symbolLabel.textColor = .hexStringUIColor(color: .titleColorLabel)
        priceLabel.font = .sfProDisplay(font: .regular, size: 18.scaleW)
    }

    private func setupLayoutViews() {
        topNameCoinLabelLC.constant = 17.scaleH
        leadingNameCoinLabelLC.constant = 20.scaleW
        topLogoImageViewLC.constant = 13.2.scaleH
        topSymbolLabelLC.constant = 15.scaleH
        leadingSymbolLabelLC.constant = 5.5.scaleW
        topPriceLabelLC.constant = 17.scaleH
        trailingPriceLabelLC.constant = 23.scaleW
    }

    func setupDataLocal(coin: CoinEntity) {
        coinEntity = coin
        nameCoinLabel.text = coin.name
        symbolLabel.text = coin.symbol
        priceLabel.text = coin.priceUSD

        if let logoUrl = coin.logo {
            logoImageView?.load(link: logoUrl)
        }
    }

    private func randomData(usdMax: Double) {
        datas = (0 ... 23).map { i in
            let usd = Double.random(in: 10000 ..< usdMax)
            return DataDrawLine(time: Double(i), usd: min(usd, usdMax))
        }
    }

    private func scalesChartView(usdMax: Double) {
        points = datas.map { CGPoint(x: $0.time * (width / 23),
                                     y: height - height * ($0.usd / usdMax)) }
    }

    func drawChartsView() {
        scalesChartView(usdMax: usd)
        drawLine()
        drawBackground()
    }

    private func drawLine() {
        // MARK: DRAW LINE CHARTS

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: points[0])
        points.enumerated().forEach { _, point in
            path.addLine(to: point)
        }
        path.addLine(to: points[points.count - 1])
        path.move(to: points[points.count - 1])
        path.close()

        shapeLayer.strokeColor = colorLine.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.path = path.cgPath
        chartView.layer.addSublayer(shapeLayer)
    }

    private func drawBackground() {
        // MARK: DRAW LINE CHARTS

        let path = UIBezierPath()
        let shape = CAShapeLayer()
        path.move(to: points[0]) // StartPoint
        for index in 0 ..< points.count - 1 {
            path.addLine(to: points[index + 1])
        }

        // MARK: DRAW LINE UIVIEW CONTAINER

        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0.0, y: height))
        path.addLine(to: points[0])
        path.close()

        // MARK: SET WIDTH LINE AND COLOR

        shape.lineWidth = 1.0
        shape.fillColor = UIColor.black.cgColor
        shape.strokeColor = UIColor.white.cgColor
        shape.path = path.cgPath

        // MARK: BACKGROUNDCOLOR

        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [colorLine.withAlphaComponent(0.2).cgColor,
                                colorLine.withAlphaComponent(0.05).cgColor, UIColor.white.withAlphaComponent(0.2).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = chartView.layer.bounds
        gradientLayer.mask = shape
        chartView.layer.addSublayer(gradientLayer)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        chartView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        containerChartView.setCornerRadius(cornerRadius: 10)
        shadowView.shadow(offset: CGSize(width: 0, height: 0), cornerRadius: 10,alpha: 0.2)
        shadowView.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
