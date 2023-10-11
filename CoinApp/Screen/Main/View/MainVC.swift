//
//  ViewController.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    private var viewModel: MainVMProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        let initilazer = MainVM(networkManager: NetworkManager())
        viewModel = initilazer
        viewModel.fetchUpComingDataList()
//        setDelegate()
    }
}

//extension MainVC: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell., for: indexPath) as! MainTableViewCell
//        return cell
//    }
//
//    private func setDelegate() {
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//}

