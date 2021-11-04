//
//  PokemonRequest.swift
//  Flygondex
//
//  Created by Samuel on 03/11/21.
//

import Foundation

struct PokemonRequest : Decodable{
    let id: Int
    let sprites: PokemonSprite
    let types: [PokemonTypePosition]
    var name : String?
}
