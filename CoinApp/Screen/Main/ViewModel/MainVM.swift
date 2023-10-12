//
//  MainVM.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import Foundation
import UIKit

protocol MainDisplayLayer: AnyObject {
    func push(controller: UIViewController)
}

protocol MainBusinessLayer {
    var numberOfItems: Int { get }
    var view: MainDisplayLayer? { get set }
    var coinArray: [Coin]? { get }
    func fetchUpComingDataList()
    func navigateToDetails(model: Coin, viewController: UIViewController)
}

class MainVM {
    let networkManager: NetworkManager<MainEndpointItem>
    weak var view: MainDisplayLayer?
    var coinArray: [Coin]? = []
    var numberOfItems: Int { coinArray?.count ?? 0 }
    
    init(networkManager: NetworkManager<MainEndpointItem>) {
        self.networkManager = networkManager
    }
    
    func fetchUpComingDataList() {
        networkManager.request(endpoint: .upcoming(query: "api/v1/dummy/coins"), type: Coins.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                coinArray = response.data?.coins
//                print(coinArray)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension MainVM: MainBusinessLayer {
    func navigateToDetails(model: Coin, viewController: UIViewController) {
        let viewModel = DetailsVM(model: model)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        resultViewController.viewModel = viewModel
        self.view?.push(controller: resultViewController)
    }
}

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
}
