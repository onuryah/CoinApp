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
    @IBOutlet weak var perPriceChangingLabel: UILabel!
    @IBOutlet weak var priceChangingLabel: UILabel!
    var viewModel: MainTableViewBusinessLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = MainTableViewCellVM()
    }
    
    func populate(model: Coin?) {
        guard let model = model else { return }
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
        currentPriceLabel.text = model.price?.formatToNumber().addCurrencySymbol()
        perPriceChangingLabel.text = (model.change ?? "") + "%"
        perPriceChangingLabel.textColor = viewModel.getColor(changeString: model.change ?? "")
        priceChangingLabel.textColor = perPriceChangingLabel.textColor
        
        guard let changingPrice = viewModel.calculateChange(inputNumberString: model.price ?? "",
                                                            percentageChangeString: model.change ?? "") else { return }
        priceChangingLabel.text = "(\(changingPrice.formatNumber(digit: .three)))"
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
