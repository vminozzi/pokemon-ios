//
//  HomeViewModel.swift
//  Pokemon
//
//  Created by Vinicius on 08/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

protocol HomeViewModelPresentable: class {
    func getPokemonList()
    func numberOfSection() -> Int
    func numberOfRows() -> Int
    func pokemonDTO(at row: Int) -> PokemonCellDTO
    func didFavorite(url: String)
}

class HomeViewModel: HomeViewModelPresentable {
    
    // MARK: - Attributes
    weak var delegate: LoadContent?
    var interactor: HomeInteractorPresentable?
    var pokemons = [Pokemon]()
    var favorites = [Pokemon]()
    
    
    // MARK: - Init
    init(delegate: LoadContent?, interactor: HomeInteractorPresentable = HomeInteractor()) {
        self.delegate = delegate
        self.interactor = interactor
        loadFavories()
    }
    
    // MARK: - HomeViewModelPresentable
    func getPokemonList() {
        interactor?.getPokemon(offset: 20, completion: { pokemons, error in
            print(error)
            print(pokemons)
            guard let results = pokemons else {
                self.delegate?.didLoadContent(error: error)
                return
            }
            self.pokemons = results
            self.delegate?.didLoadContent(error: nil)
        })
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return pokemons.count
    }
    
    func pokemonDTO(at row: Int) -> PokemonCellDTO {
        guard let pokemon = pokemons.object(index: row) else {
            return PokemonCellDTO()
        }
        return PokemonCellDTO(title: pokemon.name,
                              favorite: isFavorite(pokemon: pokemon),
                              url: pokemon.url)
    }
    
    func isFavorite(pokemon: Pokemon) -> Bool {
        return favorites.contains(pokemon)
    }
    
    func didFavorite(url: String) {
        if let pokemon = pokemons.filter({ $0.url == url }).first {
            let persistence = LocalDataBase()
            if favorites.contains(pokemon) {
                persistence.remove(object: pokemon)
            } else {
                persistence.save(object: pokemon)
            }
            loadFavories()
        }
    }
    
    func loadFavories() {
        favorites = LocalDataBase().load(object: Pokemon.self) ?? []
    }
}
