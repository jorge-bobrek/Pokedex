//
//  PokemonEvolutionManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 11/09/24.
//

import Foundation

final class EvolutionManager {
    private var evolutionChainsCache: [Int: EvolutionChain] = [:]
    
    func getEvolutionChain(for chainId: Int, completion: @escaping (EvolutionChain?) -> Void) {
        if !evolutionChainsCache.isEmpty {
            completion(self.evolutionChainsCache[chainId])
        } else {
            JSONManager.shared.load(fileName: "EvolutionChain", as: EvolutionChainResponse.self) { result in
                switch result {
                case .success(let response):
                    response.evolutionChain.forEach { chain in
                        self.evolutionChainsCache[chain.id] = chain
                    }
                    completion(self.evolutionChainsCache[chainId])
                case .failure(let error):
                    print("Error loading Pokémon chain: \(error)")
                }
            }
        }
    }
}
