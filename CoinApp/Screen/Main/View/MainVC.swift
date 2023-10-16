//
//  ViewController.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var sortTypeView: UIView!
    @IBOutlet weak var sortTypeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MainBusinessLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setDelegate()
        setGestureRecognizer()
        tableView.register(MainTableViewCell.nib, forCellReuseIdentifier: MainTableViewCell.identifier)
        collectionView.register(MainCollectionViewCell.nib, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    private func setup() {
        let initilazer = MainVM(networkManager: NetworkManager())
        viewModel = initilazer
        viewModel.fetchUpComingDataList()
        viewModel.view = self
        viewModel.delegate = self
    }
    
    private func setGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(sortTypeViewTapped))
        sortTypeView.addGestureRecognizer(tap)
    }
    
    @objc func sortTypeViewTapped() {
        collectionView.isHidden = false
        collectionView.reloadData()
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MainVC: MainDisplayLayer {
    func push(controller: UIViewController) {
        show(controller, sender: nil)
    }
}

extension MainVC: MainTableViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sortArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.populate(type: viewModel.sortArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = viewModel.sortArray[indexPath.row]
        viewModel.selectedSortType = selected
        sortTypeLabel.text = selected
        viewModel.sortDataList()
        reloadData()
        collectionView.isHidden = true
    }
    
}

