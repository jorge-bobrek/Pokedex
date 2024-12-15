//
//  PokemonItemsManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//


import Foundation

class PokemonItemsManager {
    func getItemList(completion: @escaping ([Item]) -> ()) {
        JSONManager.shared.load(fileName: "Items", as: ItemsResponse.self) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.pokemonItem)
                }
            case .failure(let error):
                print("Error loading Pokémon species: \(error)")
            }
        }
    }
}
