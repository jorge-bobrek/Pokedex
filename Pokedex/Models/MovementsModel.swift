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
    let moves: [Move]
    
    init(_ movements: MovementsData) {
        self.moves = movements.pokemon_v2_pokemonmoves.map({ move in
            Move(move)
        })
    }
}

struct Move: Decodable, Identifiable {
    let id: Int?
    let level: Int?
    let method: Int?
    let names: MoveLanguage?
    let version: LanguageModel?
    
    init(_ move: MovementsData.Pokemon_v2_pokemonmofe) {
        self.id = move.id
        self.level = move.level
        self.method = move.move_learn_method_id
        self.names = move.pokemon_v2_move.map({ move in
            MoveLanguage(move)
        })
        if let version = move.pokemon_v2_versiongroup {
            self.version = LanguageModel(id: version.id, name: version.name)
        } else {
            self.version = nil
        }
    }
    
    struct MoveLanguage: Decodable, Identifiable {
        let id: Int
        let names: [LanguageModel]
        
        init(_ move: MovementsData.Pokemon_v2_pokemonmofe.Pokemon_v2_move) {
            self.id = move.id
            self.names = move.pokemon_v2_movenames.map({ name in
                LanguageModel(id: name.language_id, name: name.name)
            })
        }
    }
}

struct SortedMovesType: Identifiable {
    let id: Int
    let generations: [SortedMovesGeneration]
}

struct SortedMovesGeneration: Identifiable {
    let id: Int
    let moves: [Move]
}
