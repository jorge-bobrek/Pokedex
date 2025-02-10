//
//  PokemonForm.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

struct PokemonForm: Decodable, Identifiable {
    let id: Int
    let name: String
    let names: [LanguageModel]
}
