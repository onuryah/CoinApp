//
//  MainVM.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import UIKit

protocol MainDisplayLayer: AnyObject {
    func push(controller: UIViewController)
}

protocol MainBusinessLayer {
    var numberOfItems: Int { get }
    var view: MainDisplayLayer? { get set }
    var coinArray: [Coin]? { get }
    var delegate: MainTableViewDelegate? { get set }
    var sortArray: [String] { get set }
    var selectedSortType: String? { get set }
    var alertDelegate: BaseDelegateProtocol? { get set }
    
    func fetchUpComingDataList()
    func navigateToDetails(model: Coin, viewController: UIViewController)
    func sortDataList()
}

protocol MainTableViewDelegate: AnyObject {
    func reloadData()
}

class MainVM {
    enum SortTypes: String {
        case price, marketCap, change, listedAt, the24HVolume
    }
    let networkManager: NetworkManager<MainEndpointItem>
    weak var view: MainDisplayLayer?
    weak var delegate: MainTableViewDelegate?
    var coinArray: [Coin]? = []
    var numberOfItems: Int { coinArray?.count ?? 0 }
    var sortArray: [String] = ["price", "marketCap", "the24HVolume", "change", "listedAt"]
    var selectedSortType: String? = ""
    var alertDelegate: BaseDelegateProtocol?
    
    init(networkManager: NetworkManager<MainEndpointItem>) {
        self.networkManager = networkManager
    }
    
    func fetchUpComingDataList() {
        networkManager.request(endpoint: .upcoming(query: ApiConstant.PATH), type: Coins.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.coinArray = response.data?.coins
                self.delegate?.reloadData()
            case .failure(let error):
                self.alertDelegate?.createFailureAlert(failMessage: error.message)
            }
        }
    }
    
    func sortDataList() {
        let keyMap: [SortTypes: KeyPath<Coin, String?>] = [
            .change: \.change,
            .price: \.price,
            .marketCap: \.marketCap,
            .the24HVolume: \.the24HVolume
        ]

        if let keyPath = keyMap[SortTypes(rawValue: selectedSortType ?? "") ?? .price] {
            coinArray = coinArray?.sorted(by: { coin1, coin2 in
                return (Double(coin1[keyPath: keyPath] ?? "") ?? 0) > (Double(coin2[keyPath: keyPath] ?? "") ?? 0)
            })
        }
        
        if SortTypes(rawValue: selectedSortType ?? "") == .listedAt {
            sortDataListByListedAt()
        }
    }
    
    private func sortDataListByListedAt() {
        coinArray = coinArray?.sorted(by: { coin1, coin2 in
            if let listedAt1 = coin1.listedAt, let listedAt2 = coin2.listedAt {
                let timestamp1 = Int(listedAt1)
                let timestamp2 = Int(listedAt2)
                return timestamp1 > timestamp2
            }
            return false
        })
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
