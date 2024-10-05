//
//  PokemonNaturesManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

import Foundation

class PokemonNaturesManager {
    func getPokemonNatures(completion: @escaping ([Nature]) -> ()) {
        JSONManager.shared.load(fileName: "Natures", as: NaturesResponse.self) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    completion(response.natures)
                }
            case .failure(let error):
                print("Error loading Pokémon natures: \(error)")
            }
        }
    }
}
