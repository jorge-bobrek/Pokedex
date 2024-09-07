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
        let name: String
        let sprite: String
        //let generation: Int
        
        init(_ species: SpeciesData) {
            self.id = species.id
            self.name = species.name
            self.sprite = Bundle.main.getSprite(for: species.id)
            //self.generation = species.pokemon_v2_generation?.id ?? 0
        }
        
        init(id: Int, name: String, sprite: String/*, generation: Int*/) {
            self.id = id
            self.name = name
            self.sprite = sprite
            //self.generation = generation
        }
        
        static let template = ListSpecy(id: 133, name: "eevee", sprite: Bundle.main.getSprite(for: 133)/*, generation: 1*/)
    }
    
}
