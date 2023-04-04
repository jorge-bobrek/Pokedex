//
//  EvolutionChainModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation

// MARK: - EvolutionChainModel
struct EvolutionChainModel: Codable {
    let babyTriggerItem: NameUrl?
    let chain: Chain
    let id: Int

    enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain, id
    }
}

// MARK: - Chain
struct Chain: Codable, Identifiable {
    var id = UUID()
    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [Chain]?
    let isBaby: Bool
    let species: NameUrl

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail
struct EvolutionDetail: Codable {
    let gender: Int?
    let heldItem: NameUrl?
    let item: NameUrl?
    let knownMove: NameUrl?
    let knownMoveType, location: NameUrl?
    let minAffection: Int?
    let minBeauty: Int?
    let minHappiness: Int?
    let minLevel: Int?
    let needsOverworldRain: Bool
    let partySpecies: NameUrl?
    let partyType: NameUrl?
    let relativePhysicalStats: Int?
    let timeOfDay: String
    let tradeSpecies: NameUrl?
    let trigger: NameUrl
    let turnUpsideDown: Bool

    enum CodingKeys: String, CodingKey {
        case gender
        case heldItem = "held_item"
        case item
        case knownMove = "known_move"
        case knownMoveType = "known_move_type"
        case location
        case minAffection = "min_affection"
        case minBeauty = "min_beauty"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case partySpecies = "party_species"
        case partyType = "party_type"
        case relativePhysicalStats = "relative_physical_stats"
        case timeOfDay = "time_of_day"
        case tradeSpecies = "trade_species"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}
