//
//  PokemonSpeciesList.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

struct PokemonSpeciesList: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let generationId: Int
    let names: [LanguageModel]
    
    static let template = PokemonSpeciesList(id: 133, name: "Eevee", generationId: 1, names: [LanguageModel(id: 7, name: "Eevee")])
}
