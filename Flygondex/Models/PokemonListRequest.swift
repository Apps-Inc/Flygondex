//
//  PokemonListRequest.swift
//  Flygondex
//
//  Created by Samuel on 01/11/21.
//

import Foundation

struct PokemonListRequest : Decodable{
    let count : Int
    let next : String
    let previous : String
    let results : [PokemonListResult]
}
