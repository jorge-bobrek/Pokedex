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
