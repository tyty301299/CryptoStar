//
//  Coin.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 29/05/2022.
//

import Foundation
import UIKit

class Coin: Codable {
    var id: Int
    var name: String
    var symbol: String
    var quote: Quote
    var logo: String? {
        didSet {
            getLogoClosure?()
        }
    }

    var priceUSD: String {
        return "$" + quote.USD.price.convertDoubletoPrice
    }

    var getLogoClosure: (() -> Void)?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case quote
        case logo
    }
}

struct Quote: Codable {
    var USD: USD
}

struct USD: Codable {
    var price: Double
    var percentChange24H: Double
}

struct CoinResponse: Codable {
    var data: [Coin]
}
