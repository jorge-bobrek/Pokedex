//
//  PokemonSpecies.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

struct PokemonSpeciesDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let genderRate: Int
    let hasGenderDifferences: Bool
    let evolvesFromSpeciesId: Int?
    let generationId: Int
    let evolutionChain: EvolutionChain
    let speciesNames: [LanguageModel]
    let color: LanguageIdentifier
    let eggGroups: [LanguageIdentifier]
    let pokemons: [PokemonDetail]
    
    static let template = PokemonSpeciesDetail(id: 151, name: "mew", genderRate: -1, hasGenderDifferences: false, evolvesFromSpeciesId: nil, generationId: 1, evolutionChain: .template, speciesNames: [LanguageModel(id: 9, name: "Mew")], color: LanguageIdentifier(id: 6, name: [LanguageModel(id: 9, name: "Pink")]), eggGroups: [LanguageIdentifier(id: 15, name: [LanguageModel(id: 9, name: "Undiscovered")])], pokemons: [.template])
}
