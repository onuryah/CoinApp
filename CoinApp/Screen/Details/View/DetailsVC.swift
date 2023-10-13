//
//  DetailVC.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var perChangeLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var highestPrice: UILabel!
    @IBOutlet weak var lowestPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DetailsBusinessProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let selectedModel = viewModel.model
        symbolLabel.text = selectedModel.symbol
        nameLabel.text = selectedModel.name
        currentPrice.text = selectedModel.price?.roundToTwoDecimalPlaces()
        perChangeLabel.text = selectedModel.change
        priceChangeLabel.text = "hesaplanacak"
        
        guard let result = calculateHigestAndLowest(sparkline: selectedModel.sparkline) else { return }
        let (highest, lowest) = result
        highestPrice.text = highest.roundToTwoDecimalPlaces()
        lowestPrice.text = lowest.roundToTwoDecimalPlaces()
    }
}

extension DetailsVC {
    private func calculateHigestAndLowest(sparkline: [String]?) -> (String, String)? {
        guard let maxString = sparkline?.max(), let minString = sparkline?.min() else { return nil }
        return (maxString, minString)
    }
}
