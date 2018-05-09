//
//  HomeInteractor.swift
//  Pokemon
//
//  Created by Vinicius on 08/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

protocol HomeInteractorPresentable: class {
    func getPokemon(offset: Int, completion: @escaping (_ list: [Pokemon]?, _ error: String?) -> ())
}

class HomeInteractor: HomeInteractorPresentable {
    
    // MARK - Get list
    func getPokemon(offset: Int, completion: @escaping (_ list: [Pokemon]?, _ error: String?) -> ()) {
        PokemonListRequest(offset: offset).request { result, error in
            guard let pokemons = result?.results else {
                completion(nil, error?.message)
                return
            }
            completion(pokemons, nil)
        }
    }
}
