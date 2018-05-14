//
//  HomeViewController.swift
//  Pokemon
//
//  Created by Vinicius on 08/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import UIKit

protocol LoadContent: class {
    func didLoadContent(error: String?)
}

class HomeViewController: UITableViewController, LoadContent, PokemonCellDelegate {
    
    // MARK: - Attributes
    lazy var viewModel: HomeViewModelPresentable = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContent()
    }
    
    func loadContent() {
        showLoader()
        viewModel.getPokemonList()
    }

    // MARK: - UITableViewDelegte/DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PokemonCell = PokemonCell.createCell(tableView: tableView, indexPath: indexPath)
        cell.fill(dto: viewModel.pokemonDTO(at: indexPath))
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(index: section)
    }

    
    // MARK: - PokemonCellDelegate
    func didFavorite(url: String) {
        viewModel.didFavorite(url: url)
    }
    
    // MAKR: - LoadContent
    func didLoadContent(error: String?) {
        dismissLoader()
        if let message = error {
            showDefaultAlert(message: message, completeBlock: nil)
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
