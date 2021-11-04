//
//  PokemonRowTableViewCell.swift
//  Flygondex
//
//  Created by Samuel on 03/11/21.
//

import UIKit

class PokemonRowTableViewCell: UITableViewCell {

    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonNum: UILabel!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonTypeOne: UIImageView!
    @IBOutlet var pokemonTypeTwo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        pokemonName.adjustsFontSizeToFitWidth = true
        // Initialization code
        pokemonImage.contentMode = .scaleAspectFit
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
