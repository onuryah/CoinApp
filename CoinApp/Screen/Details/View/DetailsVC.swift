//
//  DetailVC.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import UIKit

class DetailsVC: UIViewController {
    var viewModel: DetailsBusinessProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.model)
    }
}
