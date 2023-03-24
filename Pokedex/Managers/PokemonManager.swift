//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

class PokemonManager {
    func getPokemonList(completion: @escaping ([PokemonPage]) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon-species?limit=9999", model: PokemonList.self, completion: { data in
            completion(data.results)
        }) { error in
            print(error)
        }
    }
    
    func getPokemon(id: Int, _ completion: @escaping (Pokemon) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)", model: Pokemon.self, completion: { data in
            completion(data)
        }) { error in
            print(error)
        }
    }
}
