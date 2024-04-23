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
    var species: [Specy]

    init(_ species: [SpeciesData]) {
        self.species = species.map({ specy -> Specy in
            Specy(specy)
        })
    }

    struct Specy: Identifiable, Decodable {
        let id: Int
        let name: String
        let sprite: String
        let generation: Int
        
        init(_ species: SpeciesData) {
            self.id = species.id
            self.name = species.name
            self.sprite = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(species.id).png"
            self.generation = species.pokemon_v2_generation?.id ?? 0
        }
        
        init(id: Int, name: String, sprite: String, generation: Int) {
            self.id = id
            self.name = name
            self.sprite = sprite
            self.generation = generation
        }
        
        static let template = Specy(id: 280, name: "ralts", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/280.png", generation: 3)
    }
    
}


// MARK: - NameUrl
struct NameUrl: Codable {
    let name: String
    let url: String
}

// MARK: - Name
struct Name: Codable {
    let language: NameUrl
    let name: String
}
