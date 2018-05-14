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
    func numberOfRows(at section: Int) -> Int
    func pokemonDTO(at indexPath: IndexPath) -> PokemonCellDTO
    func didFavorite(url: String)
    func titleForSection(index: Int) -> String
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
        interactor?.getPokemon(offset: pokemons.count, completion: { pokemons, error in
            guard let results = pokemons else {
                self.delegate?.didLoadContent(error: error)
                return
            }
            results.forEach {
                if !self.isFavorite(pokemon: $0) {
                    self.pokemons.append($0)
                }
            }
            self.delegate?.didLoadContent(error: nil)
        })
    }
    
    func numberOfSection() -> Int {
        return favorites.count > 0 ? 2 : 1
    }
    
    func numberOfRows(at section: Int) -> Int {
        if favorites.count == 0 {
            return pokemons.count
        }
        return section == 0 ? favorites.count : pokemons.count
    }
    
    func pokemonDTO(at indexPath: IndexPath) -> PokemonCellDTO {
        if favorites.count == 0 {
            guard let pokemon = pokemons.object(index: indexPath.row) else {
                return PokemonCellDTO()
            }
            return PokemonCellDTO(title: pokemon.name, favorite: false, url: pokemon.url)
        }
        if indexPath.section == 0 {
            guard let pokemon = favorites.object(index: indexPath.row) else {
                return PokemonCellDTO()
            }
            return PokemonCellDTO(title: pokemon.name, favorite: true, url: pokemon.url)
        } else {
            guard let pokemon = pokemons.object(index: indexPath.row) else {
                return PokemonCellDTO()
            }
            return PokemonCellDTO(title: pokemon.name, favorite: false, url: pokemon.url)
        }
    }
    
    func isFavorite(pokemon: Pokemon) -> Bool {
        return favorites.contains(pokemon)
    }
    
    func didFavorite(url: String) {
        if let pokemon = pokemons.filter({ $0.url == url }).first {
            let persistence = LocalDataBase()
            if favorites.contains(pokemon) {
                persistence.remove(object: pokemon)
                pokemons.append(pokemon)
            } else {
                pokemons = pokemons.filter { $0 != pokemon }
                persistence.save(object: pokemon)
            }
            loadFavories()
        }
    }
    
    func loadFavories() {
        favorites = LocalDataBase().load(object: Pokemon.self) ?? []
        delegate?.didLoadContent(error: nil)
    }
    
    func titleForSection(index: Int) -> String {
        if favorites.count == 0 {
            return ""
        }
        return index == 0 ? "Favoritos" : "Pokemons"
    }
}
