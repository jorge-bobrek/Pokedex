//
//  PokemonAbility.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

struct PokemonAbility: Decodable, Identifiable {
    let id: Int
    let isHidden: Bool
    let name: [LanguageModel]
    let flavor: [LanguageModel]
}
