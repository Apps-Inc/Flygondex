//
//  ViewController.swift
//  Flygondex
//
//  Created by Samuel on 01/11/21.
//

import UIKit

class ViewController: UITableViewController {
    var pokemonList: [PokemonRequest] = []
    var pokemonRequestPosition: PokemonListRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0")!
        
        Task {
            guard let (data,_) = try? await URLSession.shared.data(from: url) else {return}
            
            guard let result = try? JSONDecoder().decode(PokemonListRequest.self, from: data) else {return}
            self.pokemonRequestPosition = result
            result.results.forEach{item in
                Task{
                    guard let pokemon = await self.loadPokemonInformation(pokemonBasicInfos: item) else {fatalError()}
                    
                    DispatchQueue.main.async {
                        let index = self.pokemonList.firstIndex {$0.id > pokemon.id} ?? self.pokemonList.endIndex
                        self.pokemonList.insert(pokemon, at: index)
                        let indexPath = IndexPath(row: index, section: 0 )
                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PokemonRowTableViewCell else {fatalError("quebrouu") }
        
        let pokemonInfo = pokemonList[indexPath.row]
        cell.pokemonNum?.text = String(pokemonInfo.id)
        cell.pokemonName?.text = pokemonInfo.name!
        cell.pokemonTypeTwo.image = nil
        DispatchQueue.global().async {
            
            if let pokemonImage = self.loadImage(url: pokemonInfo.sprites.front_default){
                
                DispatchQueue.main.async {
                    cell.pokemonImage.image = pokemonImage
                }
            }
            for pType in pokemonInfo.types {
                let typeImage = UIImage(named: pType.type.name)
                
                DispatchQueue.main.async {
                    if pType.slot == 1 {
                        cell.pokemonTypeOne.image = typeImage
                    } else {
                        cell.pokemonTypeTwo.image = typeImage
                    }
                }
                
            }
        }
        
        
        return cell
    }
    
    func loadImage(url : String) -> UIImage?{
        var imageResult : UIImage? = nil
        let pokemonImageUrl = URL(string: url)!
        if let data = try? Data(contentsOf: pokemonImageUrl) {
            if let image = UIImage(data: data){
                imageResult = image
            }
        }
        
        return imageResult
    }
    
    func loadPokemonInformation(pokemonBasicInfos : PokemonListResult) async -> PokemonRequest?{
        let pokemonUrl = URL(string: pokemonBasicInfos.url)!
        
        do {
            let (pokemonData,_) = try await URLSession.shared.data(for: URLRequest(url: pokemonUrl))
            if var pokemon = try? JSONDecoder().decode(PokemonRequest.self, from: pokemonData) {
                pokemon.name = pokemonBasicInfos.name
                return pokemon
            }
            
        }catch {}
        
        return nil
        
    }
    
    
}

