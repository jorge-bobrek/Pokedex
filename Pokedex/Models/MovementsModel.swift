//
//  MovementsModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 25/04/24.
//

import Foundation

import SchemaAPI

typealias MovementsData = GetMovesQuery.Data.Pokemon_v2_pokemon

struct Movements: Decodable {
    let movements: [Move]
    
    init(_ movements: MovementsData) {
        self.movements = movements.pokemon_v2_pokemonmoves.map {
            Move($0)
        }
    }
}

struct Move: Decodable, Identifiable {
    let id: Int?
    let level: Int?
    let versionGroupID: Int?
    let names: MoveLanguage?
    let power: Int?
    let pp: Int?
    let accuracy: Int?
    let typeID: Int?
    let damageClassId: Int?
    
    init(_ move: MovementsData.Pokemon_v2_pokemonmofe) {
        self.id = move.id
        self.level = move.level
        self.versionGroupID = move.version_group_id
        if let move = move.pokemon_v2_move {
            self.power = move.power
            self.pp = move.pp
            self.accuracy = move.accuracy
            self.typeID = move.type_id
            self.names = MoveLanguage(move.pokemon_v2_movenames)
            self.damageClassId = move.move_damage_class_id
        } else {
            self.power = nil
            self.pp = nil
            self.accuracy = nil
            self.typeID = nil
            self.names = nil
            self.damageClassId = nil
        }
    }
    
    struct MoveLanguage: Decodable {
        let names: [LanguageModel]
        
        init(_ moveNames: [MovementsData.Pokemon_v2_pokemonmofe.Pokemon_v2_move.Pokemon_v2_movename]) {
            self.names = moveNames.map { name in
                LanguageModel(id: name.language_id, name: name.name)
            }
        }
    }
}
