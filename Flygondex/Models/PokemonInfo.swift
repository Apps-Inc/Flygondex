//
//  PokemonInfo.swift
//  Flygondex
//
//  Created by Samuel on 04/11/21.
//

import Foundation
import UIKit

struct PokemonInfo{
    let id: Int
    let types: [PokemonTypePosition]
    let name : String?
    let image : UIImage
    
    init(pr : PokemonRequest, image : UIImage, name : String){
        self.id = pr.id
        self.types = pr.types
        self.image = image
        self.name = name
    }
}
