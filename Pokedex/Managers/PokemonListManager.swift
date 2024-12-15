//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

class PokemonListManager {
    func getPokemonList(completion: @escaping ([Species]) -> ()) {
        JSONManager.shared.load(fileName: "Species", as: SpeciesResponse.self) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.species)
                }
            case .failure(let error):
                print("Error loading Pokémon species: \(error)")
            }
        }
    }
}
