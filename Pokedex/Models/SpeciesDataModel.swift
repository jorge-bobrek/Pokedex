//
//  SpeciesDataModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SchemaAPI

typealias SpeciesData = GetListQuery.Data.Pokemon_v2_pokemonspecy

struct Species: Decodable {
    var species: [ListSpecy]

    init(_ species: [SpeciesData]) {
        self.species = species.map({ specy in
            ListSpecy(specy)
        })
    }

    struct ListSpecy: Identifiable, Decodable {
        let id: Int
        let names: [LanguageModel]
        let sprite: String
        //let generation: Int
        
        init(_ species: SpeciesData) {
            self.id = species.id
            self.names = species.pokemon_v2_pokemonspeciesnames.map({ name in
                LanguageModel(id: name.language_id, name: name.name)
            })
            self.sprite = Bundle.main.getSprite(for: species.id)
            //self.generation = species.pokemon_v2_generation?.id ?? 0
        }
        
        init(id: Int, names: [LanguageModel], sprite: String/*, generation: Int*/) {
            self.id = id
            self.names = names
            self.sprite = sprite
            //self.generation = generation
        }
        
        static let template = ListSpecy(id: 133, names: [LanguageModel(id: 7, name: "eevee")], sprite: Bundle.main.getSprite(for: 133)/*, generation: 1*/)
    }
    
}
