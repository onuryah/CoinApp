//
//  MainVM.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

import Foundation

protocol MainVMProtocol {
    var numberOfItems: Int { get }
    var coinArray: [Coin]? { get }
    func fetchUpComingDataList()
}

class MainVM {
    let networkManager: NetworkManager<MainEndpointItem>
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

extension MainVM: MainVMProtocol {
}
