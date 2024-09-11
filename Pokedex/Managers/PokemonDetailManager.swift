//
//  PokemonDetailManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation

class PokemonDetailManager {
    private var pokemonsCache: [Int: PokemonDetail] = [:]
    
    func getPokemon(id: Int, _ completion: @escaping (PokemonDetail?) -> ()) {
        if !pokemonsCache.isEmpty {
            completion(self.pokemonsCache[id])
        } else {
            JSONManager.shared.load(fileName: "PokemonDetails", as: PokemonDetailResponse.self) { result in
                switch result {
                case .success(let response):
                    response.pokemonDetails.forEach { detail in
                        self.pokemonsCache[detail.id] = detail
                    }
                    completion(self.pokemonsCache[id])
                case .failure(let error):
                    print("Error loading Pokémon chain: \(error)")
                }
            }
        }
    }
}
