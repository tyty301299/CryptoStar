//
//  Coin.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 29/05/2022.
//
import UIKit

struct CoinResponse: Codable {
    var status: Status
    var data: [Coin]?
}

class Status: Codable {
    var errorMessage: String?
}

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

    var checkSwitch: Bool = false
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

struct DataDrawLine {
    var time: Double
    var usd: Double
}

struct CoinEntities {
    var data: [CoinEntity]
}

struct Limit {
    static var email = 256
    static var password = 8
    static var numberPhone = 11
}
