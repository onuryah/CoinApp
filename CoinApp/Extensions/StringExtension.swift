//
//  StringExtension.swift
//  CoinApp
//
//  Created by OnurAlp on 13.10.2023.
//
import Foundation

extension String {
    enum Digits: Int {
        case zero,one,two,three
    }
    
    func formatNumber(digit: Self.Digits) -> String {
        if self.contains(".") {
            let components = self.components(separatedBy: ".")
            var decimalPart = components[1]
                decimalPart = String(decimalPart.prefix(digit.rawValue))
            
            return components[0] + "." + decimalPart
        }
        
        return self
    }
    
    func addCurrencySymbol() -> String {
        let formattedString = "$" + self
        return formattedString
    }
}

