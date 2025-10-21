//
//  MainViewModel.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 07.10.25.
//

import Foundation

class MainViewModel {
    
    var exchangeRate: Currency?
    
    let networkManager = NetworkManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func loadCurrencyRate(of currency: String) {
        networkManager.request(endpoint: .currency, currency: currency, model: Currency.self) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.exchangeRate = data
                self.success?()
            }
        }
    }
}
