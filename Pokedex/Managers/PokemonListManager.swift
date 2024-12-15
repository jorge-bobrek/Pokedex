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

enum ItemPocket: Int, CaseIterable {
    case misc = 1
    case medicine = 2
    case pokeballs = 3
    case machines = 4
    case berries = 5
    case mail = 6
    case battle = 7
    case key = 8
}
