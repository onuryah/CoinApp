//
//  MainnTableViewCell.swift
//  CoinApp
//
//  Created by OnurAlp on 11.10.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var priceChangingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(model: Coin?) {
        guard let model = model else { return }
//        print(model.iconURL)
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
        currentPriceLabel.text = model.price
        priceChangingLabel.text = model.change
    }
    
}


extension MainTableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
