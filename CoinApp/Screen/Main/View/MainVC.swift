//
//  ViewController.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    var viewModel: MainBusinessLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setDelegate()
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    private func setup() {
        let initilazer = MainVM(networkManager: NetworkManager())
        viewModel = initilazer
        viewModel.fetchUpComingDataList()
        viewModel.view = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.tableView.reloadData()
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        let model = viewModel.coinArray?[indexPath.row]
        cell.populate(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = (viewModel.coinArray?[indexPath.row])!
        viewModel.navigateToDetails(model: selectedModel, viewController: self)
    }

    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension MainVC: MainDisplayLayer {
    func push(controller: UIViewController) {
        show(controller, sender: nil)
    }
}

