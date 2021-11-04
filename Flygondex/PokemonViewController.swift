//
//  PokemonViewController.swift
//  Flygondex
//
//  Created by Samuel on 04/11/21.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet var name: UILabel!
    @IBOutlet var number: UILabel!
    @IBOutlet var generation: UILabel!
    @IBOutlet var typeOne: UIImageView!
    @IBOutlet var typeTwo: UIImageView!
    @IBOutlet var pokemonImage: UIImageView!
    var pokemonInfo : PokemonInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pokemonInfo?.name
        
        name.text = pokemonInfo?.name
        number.text = String(pokemonInfo!.id)
        pokemonImage.image = pokemonInfo?.image
        typeOne.image = UIImage(named: (pokemonInfo?.types[0].type.name)!)
        if let typeName = pokemonInfo?.types[1].type.name{
            typeOne.image = UIImage(named: typeName)
        }
    
    }
    
    
    
}
