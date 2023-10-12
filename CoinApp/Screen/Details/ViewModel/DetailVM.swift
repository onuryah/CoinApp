//
//  DetailVM.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import Foundation

protocol DetailsBusinessProtocol {
    var model: Coin { get }
}

final class DetailsVM {
    var model: Coin
    
    init(model: Coin) {
        self.model = model
    }
}

extension DetailsVM: DetailsBusinessProtocol {
    
}
