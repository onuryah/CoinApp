//
//  MainTableViewViewModel.swift
//  CoinApp
//
//  Created by OnurAlp on 16.10.2023.
//

import UIKit

protocol MainTableViewBusinessLayer {
    func getColor(changeString: String) -> UIColor
    func calculateChange(inputNumberString: String, percentageChangeString: String) -> String?
}

final class MainTableViewCellVM: MainTableViewBusinessLayer {
    func calculateChange(inputNumberString: String, percentageChangeString: String) -> String? {
        PriceHelper.shared.calculateChange(inputNumberString: inputNumberString,
                                           percentageChangeString: percentageChangeString)
    }
    
    func getColor(changeString: String) -> UIColor {
        PriceHelper.shared.getColor(changeString: changeString)
    }
}
