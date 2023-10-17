//
//  MainModel.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//


// MARK: - Coins
struct Coins: Codable {
    let status: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let coins: [Coin]?
}

// MARK: - Coin
struct Coin: Codable {
    let symbol, name: String?
    let iconUrl: String?
    let marketCap, price: String?
    let listedAt: Int?
    let change: String?
    let sparkline: [String]?
    let the24HVolume: String?

    enum CodingKeys: String, CodingKey {
        case symbol, name, iconUrl, marketCap, price, listedAt, change, sparkline, the24HVolume = "24hVolume"
    }
}
