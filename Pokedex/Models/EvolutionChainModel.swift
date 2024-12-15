//
//  EvolutionChainModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 24/04/24.
//

struct EvolutionChainResponse: Decodable {
    let evolutionChain: [EvolutionChain]
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "pokemon_v2_evolutionchain"
    }
}

struct EvolutionChain: Decodable {
    let id: Int
    let pokemonSpecies: [Species]

    enum CodingKeys: String, CodingKey {
        case id
        case pokemonSpecies = "pokemon_v2_pokemonspecies"
    }
}

// Modelo para las evoluciones
struct Evolution: Decodable {
    let id: Int
    let minLevel: Int?
    let minAffection: Int?
    let minHappiness: Int?
    let minBeauty: Int?
    let needsOverworldRain: Bool
    let timeOfDay: String
    let relativePhysicalStats: Int?
    let trigger: EvolutionTrigger
    let heldItem: Item?
    let location: Location?
    let knownMove: MoveDetail?
    let knownMoveType: TypeDetail?
    let tradeSpecies: Species?
    let partySpecies: Species?
    let partyType: TypeDetail?
    let turnUpsideDown: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case minLevel = "min_level"
        case minAffection = "min_affection"
        case minHappiness = "min_happiness"
        case minBeauty = "min_beauty"
        case needsOverworldRain = "needs_overworld_rain"
        case timeOfDay = "time_of_day"
        case relativePhysicalStats = "relative_physical_stats"
        case trigger = "pokemon_v2_evolutiontrigger"
        case heldItem = "pokemon_v2_item"
        case location = "pokemon_v2_location"
        case knownMove = "pokemon_v2_move"
        case knownMoveType = "pokemon_v2_type"
        case tradeSpecies = "trade_species"
        case partySpecies = "pokemon_v2_pokemonspecies"
        case partyType = "party_type"
        case turnUpsideDown = "turn_upside_down"
    }
}

// Modelo para el trigger de evolución
struct EvolutionTrigger: Decodable {
    let id: Int
    let name: String
}

// Modelo para las ubicaciones
struct Location: Decodable {
    let id: Int
    let names: [LanguageModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case names = "pokemon_v2_locationnames"
    }
}

// Modelo para el tipo de daño de un movimiento
struct DamageClass: Decodable {
    let id: Int
    let name: String
}

let EvolutionType: [Int: String] = [
    1: "level-up",
    2: "trade",
    3: "use-item",
    4: "shed",
    5: "spin",
    6: "tower-of-darkness",
    7: "tower-of-waters",
    8: "three-critical-hits",
    9: "take-damage",
    10: "other",
    11: "agile-style-move",
    12: "strong-style-move",
    13: "recoil-damage"
]
