//
//  PokemonListRequest.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class PokemonListRequest: Requestable {
    
    fileprivate var offset = 0
    
    init(offset: Int) {
        self.offset = offset
    }
    
    func request(completion: @escaping (PokemonListResult?, CustomError?) -> Void) {
        var urlComponents = URLComponents(string: BaseAPI().base)
        urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "20"), URLQueryItem(name: "offset", value: "\(offset)")]
        
        guard let url = urlComponents?.url else {
            completion(nil, CustomError())
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            let result = data <--> (PokemonListResult.self, error)
            completion(result.model, result.error)
            }.resume()
    }
}
