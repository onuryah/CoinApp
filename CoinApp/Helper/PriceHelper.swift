//
//  PriceHelper.swift
//  CoinApp
//
//  Created by OnurAlp on 16.10.2023.
//

import UIKit

struct PriceHelper {
    static let shared = PriceHelper()
    func calculateChange(inputNumberString: String, percentageChangeString: String) -> String? {
        guard let inputNumber = Double(inputNumberString),
              let percentageChange = Double(percentageChangeString) else {
            return nil
        }

        let sign = percentageChange < 0 ? "-" : "+"
        let absolutePercentageChange = abs(percentageChange)
        let changeAmount = inputNumber * (absolutePercentageChange / 100.0)
        let result = inputNumber + (percentageChange < 0 ? -changeAmount : changeAmount)
        let difference = String(inputNumber - result).replacingOccurrences(of: "-", with: "").addCurrencySymbol()
        return "\(sign)\(difference)"
    }
    
    func getColor(changeString: String) -> UIColor {
        guard let change = Float(changeString) else {
            return .black
        }
        
        switch change {
        case ..<0:
            return .red
        case 0...:
            return .green
        default:
            return .black
        }
    }
}
