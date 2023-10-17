//
//  ArrayExtension.swift
//  CoinApp
//
//  Created by OnurAlp on 17.10.2023.
//

extension Array where Element == Coin {
    func sortedBy<T: Comparable>(_ keyPath: KeyPath<Coin, T>) -> [Coin] {
        return self.sorted { coin1, coin2 in
            return coin1[keyPath: keyPath] < coin2[keyPath: keyPath]
        }
    }
}
