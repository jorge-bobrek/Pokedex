//
//  SpeciesModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/03/23.
//

import Foundation

// MARK: - Species
struct SpeciesModel: Codable {
    let baseHappiness, captureRate: Int
    let color: NameUrl
    let eggGroups: [NameUrl]
    let evolutionChain: EvolutionChain
    let evolvesFromSpecies: NameUrl?
    let flavorTextEntries: [FlavorTextEntrySpecies]
    let formDescriptions: [FormDescription?]
    let formsSwitchable: Bool
    let genderRate: Int
    let genera: [Genus]
    let generation, growthRate: NameUrl
    let habitat: NameUrl?
    let hasGenderDifferences: Bool
    let hatchCounter, id: Int
    let isBaby, isLegendary, isMythical: Bool
    let name: String
    let names: [Name]
    let order: Int
    let palParkEncounters: [PalParkEncounter]
    let pokedexNumbers: [PokedexNumber]
    let shape: NameUrl
    let varieties: [Variety]

    enum CodingKeys: String, CodingKey {
        case baseHappiness = "base_happiness"
        case captureRate = "capture_rate"
        case color
        case eggGroups = "egg_groups"
        case evolutionChain = "evolution_chain"
        case evolvesFromSpecies = "evolves_from_species"
        case flavorTextEntries = "flavor_text_entries"
        case formDescriptions = "form_descriptions"
        case formsSwitchable = "forms_switchable"
        case genderRate = "gender_rate"
        case genera, generation
        case growthRate = "growth_rate"
        case habitat
        case hasGenderDifferences = "has_gender_differences"
        case hatchCounter = "hatch_counter"
        case id
        case isBaby = "is_baby"
        case isLegendary = "is_legendary"
        case isMythical = "is_mythical"
        case name, names, order
        case palParkEncounters = "pal_park_encounters"
        case pokedexNumbers = "pokedex_numbers"
        case shape, varieties
    }
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String
}

// MARK: - FlavorTextEntry
struct FlavorTextEntrySpecies: Codable {
    let flavorText: String
    let language, version: NameUrl

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language, version
    }
}

// MARK: - FormDescription
struct FormDescription: Codable {
    let description: String
    let language: NameUrl
}

// MARK: - Genus
struct Genus: Codable {
    let genus: String
    let language: NameUrl
}

// MARK: - PalParkEncounter
struct PalParkEncounter: Codable {
    let area: NameUrl
    let baseScore, rate: Int

    enum CodingKeys: String, CodingKey {
        case area
        case baseScore = "base_score"
        case rate
    }
}

// MARK: - PokedexNumber
struct PokedexNumber: Codable {
    let entryNumber: Int
    let pokedex: NameUrl

    enum CodingKeys: String, CodingKey {
        case entryNumber = "entry_number"
        case pokedex
    }
}

// MARK: - Variety
struct Variety: Codable {
    let isDefault: Bool
    let pokemon: NameUrl

    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}
