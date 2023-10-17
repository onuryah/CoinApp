//
//  MainEndpointItem.swift
//  CoinApp
//
//  Created by OnurAlp on 10.10.2023.
//

enum MainEndpointItem: Endpoint {
    
    case upcoming(query: String)
    
    var baseUrl: String { ApiConstant.BASE_URL }
    
    var path: String { ApiConstant.PATH }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
}
