//
//  NetworkManager.swift
//  CurrencyConverterApp
//
//  Created by Ceyhun Məmmədli on 07.10.25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func request<T: Codable>(endpoint: Endpoint,
                             currency: String,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             completion: @escaping ((T?, String?) -> Void)) {
        
        let url = NetworkingHelper.shared.configureURL(endpoint: endpoint, currency: currency)
        
        AF.request(url, method: method, parameters: parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
