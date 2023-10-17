//
//  DetailVC.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import UIKit

final class DetailsVC: BaseVC {
    @IBOutlet weak private var symbolLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var currentPrice: UILabel!
    @IBOutlet weak private var perChangeLabel: UILabel!
    @IBOutlet weak private var priceChangeLabel: UILabel!
    @IBOutlet weak private var highestPrice: UILabel!
    @IBOutlet weak private var lowestPrice: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var timeStampLabel: UILabel!
    @IBOutlet weak private var rankLabel: UILabel!
    
    var viewModel: DetailsBusinessProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let selectedModel = viewModel?.model
        symbolLabel.text = selectedModel?.symbol
        nameLabel.text = selectedModel?.name
        currentPrice.text = selectedModel?.price?.formatNumber(digit: .two).addCurrencySymbol()
        perChangeLabel.text = selectedModel?.change
        perChangeLabel.textColor = viewModel?.getColor(changeString: selectedModel?.change ?? "")
        timeStampLabel.text = selectedModel?.listedAt?.unixTimestampToDate()
        
        setDelegates()
        guard let rank = selectedModel?.rank else { return }
        rankLabel.text = "\(rank)"
        guard let price = viewModel?.calculateChange(inputNumberString: selectedModel?.price ?? "",
                                                    percentageChangeString: selectedModel?.change ?? "")?.formatNumber(digit: .two) else { return }
        priceChangeLabel.text = "(\(price))"
        priceChangeLabel.textColor = perChangeLabel.textColor
        guard let result = viewModel?.calculateHigestAndLowest(sparkline: selectedModel?.sparkline) else { return }
        let (highest, lowest) = result
        highestPrice.text = highest.formatNumber(digit: .two)
        highestPrice.textColor = .green
        lowestPrice.text = lowest.formatNumber(digit: .two)
        lowestPrice.textColor = .red
    }
}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel?.model.sparkline?[indexPath.row].formatNumber(digit: .two)
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
