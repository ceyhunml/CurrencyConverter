//
//  NetworkingHelper.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 07.10.25.
//

import Foundation

enum Endpoint: String {
    case currency = "latest"
}

class NetworkingHelper {
    
    private let baseURL = "https://v6.exchangerate-api.com/"
    
    private let version = "v6"
    
    private let APIKey = "91a1f264eda9d80ed6a72abf"
    
    static let shared = NetworkingHelper()
    
    func configureURL(endpoint: Endpoint, currency: String) -> String {
        baseURL + version + "/" + APIKey + "/" + endpoint.rawValue + "/" + currency
    }
}
