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
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var viewModel: DetailsBusinessProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let selectedModel = viewModel.model
        symbolLabel.text = selectedModel.symbol
        nameLabel.text = selectedModel.name
        currentPrice.text = selectedModel.price?.roundToTwoDecimalPlaces(digit: .two)
        perChangeLabel.text = selectedModel.change
        priceChangeLabel.text = "hesaplanacak"
        timeStampLabel.text = selectedModel.listedAt?.unixTimestampToDate()
        
        guard let result = calculateHigestAndLowest(sparkline: selectedModel.sparkline) else { return }
        let (highest, lowest) = result
        highestPrice.text = highest.roundToTwoDecimalPlaces(digit: .two)
        lowestPrice.text = lowest.roundToTwoDecimalPlaces(digit: .two)
        
        setDelegates()
    }
}

extension DetailsVC {
    private func calculateHigestAndLowest(sparkline: [String]?) -> (String, String)? {
        guard let maxString = sparkline?.max(), let minString = sparkline?.min() else { return nil }
        return (maxString, minString)
    }
}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.model.sparkline?[indexPath.row].roundToTwoDecimalPlaces(digit: .two)
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
