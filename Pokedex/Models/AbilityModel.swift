//
//  AbilityModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/03/23.
//

import Foundation

// MARK: - Ability
struct AbilityModel: Codable {
    let effectChanges: [EffectChange]
    let effectEntries: [AbilityEffectEntry]
    let flavorTextEntries: [FlavorTextEntryAbilities]
    let generation: NameUrl
    let id: Int
    let isMainSeries: Bool
    let name: String
    let names: [Name]
    let pokemon: [Pokemon]

    enum CodingKeys: String, CodingKey {
        case effectChanges = "effect_changes"
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case generation, id
        case isMainSeries = "is_main_series"
        case name, names, pokemon
    }
}

// MARK: - EffectChange
struct EffectChange: Codable {
    let effectEntries: [EffectChangeEffectEntry]
    let versionGroup: NameUrl

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case versionGroup = "version_group"
    }
}

// MARK: - EffectChangeEffectEntry
struct EffectChangeEffectEntry: Codable {
    let effect: String
    let language: NameUrl
}

// MARK: - AbilityEffectEntry
struct AbilityEffectEntry: Codable {
    let effect: String
    let language: NameUrl
    let shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

// MARK: - FlavorTextEntry
struct FlavorTextEntryAbilities: Codable {
    let flavorText: String
    let language, versionGroup: NameUrl

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case versionGroup = "version_group"
    }
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let isHidden: Bool
    let pokemon: NameUrl
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case pokemon, slot
    }
}
