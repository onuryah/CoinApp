//
//  DetailVM.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import Foundation
import UIKit

protocol DetailsBusinessProtocol {
    var model: Coin { get }
    var numberOfItems: Int { get }
    func getColor(changeString: String) -> UIColor
    func calculateHigestAndLowest(sparkline: [String]?) -> (String, String)?
    func calculateChange(inputNumberString: String, percentageChangeString: String) -> String?
}

final class DetailsVM {
    var model: Coin
    var numberOfItems: Int { model.sparkline?.count ?? 0 }
    
    init(model: Coin) {
        self.model = model
    }
}

extension DetailsVM: DetailsBusinessProtocol {
    func getColor(changeString: String) -> UIColor {
        PriceHelper.shared.getColor(changeString: changeString)
    }
    
    func calculateHigestAndLowest(sparkline: [String]?) -> (String, String)? {
        guard let maxString = sparkline?.max(), let minString = sparkline?.min() else { return nil }
        return (maxString, minString)
    }
    
    func calculateChange(inputNumberString: String, percentageChangeString: String) -> String? {
        PriceHelper.shared.calculateChange(inputNumberString: inputNumberString,
                                           percentageChangeString: percentageChangeString)
    }
}
