//
//  ViewController.swift
//  Flygondex
//
//  Created by Samuel on 01/11/21.
//

import UIKit

class ViewController: UITableViewController {
    var pokemonList: PokemonListRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100&offset=200")!
        
        
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            if let result = try? JSONDecoder().decode(PokemonListRequest.self, from: data) {
                DispatchQueue.main.async {
                    self.pokemonList = result
                    self.tableView.reloadData()
                    
                }
            } else {
                print("error")
            }
            
            
        }.resume()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("mudou o tamanho \(pokemonList?.count ?? 0)")
        return pokemonList?.results.count  ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PokemonRowTableViewCell else {fatalError("quebrouu") }
        
        let pokemonInfo = pokemonList?.results[indexPath.row]
                
        cell.pokemonName?.text = pokemonInfo.name
        return cell
    }
    
}

