//
//  EvolutionChainModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 24/04/24.
//

struct EvolutionChainResponse: Decodable {
    let evolutionChain: [EvolutionChain]
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "pokemon_v2_evolutionchain"
    }
}

struct EvolutionChain: Decodable {
    let id: Int
    let pokemonSpecies: [Species]

    enum CodingKeys: String, CodingKey {
        case id
        case pokemonSpecies = "pokemon_v2_pokemonspecies"
    }
}
