//
//  MovementsModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 25/04/24.
//

import Foundation

struct PokemonMovesResponse: Decodable {
    let pokemon: [Pokemon]

    enum CodingKeys: String, CodingKey {
        case pokemon = "pokemon_v2_pokemon"
    }
}

struct Pokemon: Identifiable, Decodable {
    let id: Int
    let moves: [PokemonMove]

    enum CodingKeys: String, CodingKey {
        case id
        case moves = "pokemon_v2_pokemonmoves"
    }
}


struct MoveDetailsResponse: Decodable {
    let moves: [MoveDetail]

    enum CodingKeys: String, CodingKey {
        case moves = "pokemon_v2_move"
    }
}

struct PokemonMove: Decodable, Identifiable, Hashable {
    let id: Int
    let moveId: Int
    let level: Int
    let versionGroupId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case moveId = "move_id"
        case level
        case versionGroupId = "version_group_id"
    }

    // Conformidad a Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: PokemonMove, rhs: PokemonMove) -> Bool {
        return lhs.moveId == rhs.moveId && lhs.level == rhs.level && lhs.versionGroupId == rhs.versionGroupId
    }
}

struct MoveDetail: Identifiable, Decodable, Hashable {
    let id: Int
    let power: Int?
    let pp: Int?
    let accuracy: Int?
    let typeId: Int?
    let moveDamageClassId: Int?
    let moveNames: [LanguageModel]

    enum CodingKeys: String, CodingKey {
        case id
        case power
        case pp
        case accuracy
        case typeId = "type_id"
        case moveDamageClassId = "move_damage_class_id"
        case moveNames = "pokemon_v2_movenames"
    }

    // Conformidad a Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: MoveDetail, rhs: MoveDetail) -> Bool {
        return lhs.id == rhs.id
    }
}
