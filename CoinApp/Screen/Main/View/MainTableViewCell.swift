//
//  MainnTableViewCell.swift
//  CoinApp
//
//  Created by OnurAlp on 11.10.2023.
//

import UIKit
import SDWebImageSVGCoder

final class MainTableViewCell: UITableViewCell {
    @IBOutlet weak private var symbolLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var currentPriceLabel: UILabel!
    @IBOutlet weak private var perPriceChangingLabel: UILabel!
    @IBOutlet weak private var priceChangingLabel: UILabel!
    @IBOutlet weak private var iconImage: UIImageView!
    var viewModel: MainTableViewBusinessLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = MainTableViewCellVM()
    }
    
    func populate(model: Coin?) {
        guard let model = model else { return }
        symbolLabel.text = model.symbol
        nameLabel.text = model.name
        currentPriceLabel.text = model.price?.formatNumber(digit: .three).addCurrencySymbol()
        perPriceChangingLabel.text = (model.change ?? "") + "%"
        perPriceChangingLabel.textColor = viewModel.getColor(changeString: model.change ?? "")
        priceChangingLabel.textColor = perPriceChangingLabel.textColor
        
        guard let url = URL(string: model.iconUrl ?? "") else { return }
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        iconImage.sd_setImage(with: url)
        
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
