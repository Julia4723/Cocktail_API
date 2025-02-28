//
//  NetworkManager.swift
//  Cocktail_API
//
//  Created by user on 24.02.2025.
//

import UIKit
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "zLdf+dq0n7PCeR4dz2GdlA==2hrGOLktKwqRXTpQ"
    var name = ""
    private init() {}
    
    func fetchAF(completion: @escaping (Result<[Model], AFError>) -> Void) {
        let URLString = "https://api.api-ninjas.com/v1/cocktail?name="+name

        guard let url = URL(string: URLString) else {
            completion(.failure(AFError.invalidURL(url: URLString)))
            return
        }
        
        var request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        AF.request(request)
            .validate()
            .responseDecodable(of: [Model].self, decoder: decoder) { response in
                switch response .result {
                case .success(let modelResponse):
                    print("Success: \(modelResponse)")
                    completion(.success(modelResponse))
                case .failure(let error):
                    print("Error \(error)")
                    completion(.failure(error))
                }
            }
    }
}
