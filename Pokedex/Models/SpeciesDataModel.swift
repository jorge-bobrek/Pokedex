//
//  SpeciesDataModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

struct SpeciesResponse: Decodable {
    let species: [Species]

    enum CodingKeys: String, CodingKey {
        case species = "pokemon_v2_pokemonspecies"
    }
}

struct Species: Identifiable, Decodable, Equatable {
    static func == (lhs: Species, rhs: Species) -> Bool { lhs.id == rhs.id }
    
    let id: Int
    let generationId: Int
    let evolvesFromSpeciesId: Int?
    let names: [LanguageModel]

    enum CodingKeys: String, CodingKey {
        case id
        case generationId = "generation_id"
        case evolvesFromSpeciesId = "evolves_from_species_id"
        case names = "pokemon_v2_pokemonspeciesnames"
    }
    
    static let template = Species(id: 133, generationId: 1, evolvesFromSpeciesId: nil, names: [LanguageModel(id: 7, name: "Eevee")])
}
