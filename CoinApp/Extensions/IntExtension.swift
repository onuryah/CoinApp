//
//  IntExtension.swift
//  CoinApp
//
//  Created by OnurAlp on 13.10.2023.
//

import Foundation

extension Int {
    func unixTimestampToDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return dateFormatter.string(from: date)
    }
}
