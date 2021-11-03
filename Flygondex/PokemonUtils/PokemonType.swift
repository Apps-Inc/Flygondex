//
//  PokemonType.swift
//  Flygondex
//
//  Created by Samuel on 03/11/21.
//

import Foundation

struct PokemonTypePosition : Decodable{
    let slot: Int
    let type: PokemonType
}

struct PokemonType : Decodable{
    let name: String
    let url: String
}
