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
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=100")!
        
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                
                if let result = try? JSONDecoder().decode(PokemonListRequest.self, from: data) {
                    
                    self.pokemonRequestPosition = result
                    self.pokemonRequestPosition!.results.forEach{
                        requestInfo in
                        
                        let pokemonUrl = URL(string: requestInfo.url)!
                        URLSession.shared.dataTask(with: pokemonUrl){ (pokemonData, response, error) in
                            
                            if var pokemon = try? JSONDecoder().decode(PokemonRequest.self, from: pokemonData!) {
                                
                                DispatchQueue.main.async {
                                    
                                    pokemon.name = requestInfo.name
                                    let index = self.pokemonList.firstIndex {$0.id > pokemon.id} ?? self.pokemonList.endIndex
                                    self.pokemonList.insert(pokemon, at: index)
                                    
                                    let indexPath = IndexPath(row: index, section: 0 )
                                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                                }
                            }
                        }.resume()
                        
                    }

                } else {
                    print("error")
                }
            }.resume()
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
        
        return cell
    }
    
}

