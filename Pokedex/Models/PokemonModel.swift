//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

struct PokemonList: Codable {
    let count: Int
    let next: String?
    let results: [PokemonPage]
}

struct PokemonPage: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    static let example = PokemonPage(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1")
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    var types: [types]
}

struct types: Codable, Identifiable {
    var id: Int { slot }
    let slot: Int
    let type: type
}

struct type: Codable {
    let name: String
}
