//
//  ApiConstant.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

struct ApiConstant {
    let BASE_URL = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/"
    let PATH = "api/v1/dummy/coins"
    
    func findUrl() -> String {
        return BASE_URL+PATH
    }
}
