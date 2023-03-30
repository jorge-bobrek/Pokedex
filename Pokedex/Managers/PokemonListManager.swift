//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

class PokemonListManager {
    func getPokemonList(completion: @escaping ([PokemonPage]) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon-species?limit=9999", model: PokemonList.self, completion: { data in
            completion(data.results)
        }) { error in
            print(error)
        }
    }
}
