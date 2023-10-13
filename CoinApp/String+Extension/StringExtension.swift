//
//  StringExtension.swift
//  CoinApp
//
//  Created by OnurAlp on 13.10.2023.
//
import Foundation

extension String {
    enum Digits {
        case one,two,tree
    }
    func roundToTwoDecimalPlaces(digit: String.Digits) -> String? {
        guard let number = Double(self) else {
            return nil
        }
        return String(format: "%.\(digit)f", number)
    }
}

