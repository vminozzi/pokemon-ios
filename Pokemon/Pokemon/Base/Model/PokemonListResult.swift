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
        
    }
    
    static func ==(lhs: PokemonListResult, rhs: PokemonListResult) -> Bool {
        return lhs.count == rhs.count && lhs.results == rhs.results
    }
}
