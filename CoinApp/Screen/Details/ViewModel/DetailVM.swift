//
//  DetailVM.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import Foundation

protocol DetailsBusinessProtocol {
    var model: Coin { get }
    var numberOfItems: Int { get }
}

final class DetailsVM {
    var model: Coin
    var numberOfItems: Int { model.sparkline?.count ?? 0 }
    
    init(model: Coin) {
        self.model = model
    }
}

extension DetailsVM: DetailsBusinessProtocol {
    
}
