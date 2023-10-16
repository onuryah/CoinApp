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
