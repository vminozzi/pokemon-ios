//
//  PokemonListResult.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

struct PokemonListResult: Mappable {
    
    var count = 0
    var results = [Pokemon]()
    
    init?(data: Data) {
        guard let decoded = try? JSONDecoder().decode(PokemonListResult.self, from: data) else {
            return
        }
        count = decoded.count
        results = decoded.results
    }
}
