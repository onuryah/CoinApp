//
//  MainCollectionViewCell.swift
//  CoinApp
//
//  Created by OnurAlp on 16.10.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var typeLabel: UILabel!
    
    func populate(type: String) {
        typeLabel.text = type
    }
}

extension MainCollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
