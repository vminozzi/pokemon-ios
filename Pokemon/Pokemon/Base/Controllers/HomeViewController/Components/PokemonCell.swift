//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import UIKit

struct PokemonCellDTO {
    var title = ""
    var favorite = false
    var url = ""
}

protocol PokemonCellDelegate: class {
    func didFavorite(url: String)
}

class PokemonCell: UITableViewCell {

    // MARK: - Attributes
    weak var delegate: PokemonCellDelegate?
    fileprivate var url = ""
    
    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Fill
    func fill(dto: PokemonCellDTO) {
        titleLabel.text = dto.title
        favoriteButton.isSelected = dto.favorite
        url = dto.url
    }
    
    // MARK: - IBAction
    @IBAction func didFavorite() {
        favoriteButton.isSelected = !favoriteButton.isSelected
        delegate?.didFavorite(url: url)
    }
}
