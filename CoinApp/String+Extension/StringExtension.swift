//
//  StringExtension.swift
//  CoinApp
//
//  Created by OnurAlp on 13.10.2023.
//

extension String {
    func roundToTwoDecimalPlaces() -> String? {
        guard let number = Double(self) else {
            return nil
        }
        return String(format: "%.2f", number)
    }
}

