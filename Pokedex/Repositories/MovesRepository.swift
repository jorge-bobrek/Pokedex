//
//  MovesRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 18/12/24.
//

import Foundation
import SQLite3

class MovesRepository {
    func getAllMoves(forPokemonId pokemonId: Int,_ language: Language) -> [PokemonMove] {
        let query = """
            SELECT pm.move_id, pm.level, pm.version_group,
                   mv.power, mv.pp, mv.accuracy, mv.type_id, mv.move_damage_class_id,
                   nm.name
            FROM pokemon_v2_pokemonmoves pm
            LEFT JOIN main.pokemon_v2_move mv on pm.move_id = mv.move_id
            LEFT JOIN main.pokemon_v2_movenames nm on mv.move_id = nm.move_id
            WHERE pm.pokemon_id = \(pokemonId) and nm.language_id = \(language.rawValue)
            ORDER BY pm.level;
        """
        var moves = [PokemonMove]()

        if let stmt = DatabaseHelper.shared.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let moveId = Int(sqlite3_column_int(stmt, 0))
                let level = Int(sqlite3_column_int(stmt, 1))
                let versionGroup = Int(sqlite3_column_int(stmt, 2))
                let power = Int(sqlite3_column_int(stmt, 3))
                let pp = Int(sqlite3_column_int(stmt, 4))
                let accuracy = Int(sqlite3_column_int(stmt, 5))
                let typeId = Int(sqlite3_column_int(stmt, 6))
                let moveDamageClassId = Int(sqlite3_column_int(stmt, 7))
                let name = String(cString: sqlite3_column_text(stmt, 8))
                
                moves.append(PokemonMove(id: moveId, level: level, versionGroupId: versionGroup, power: power, pp: pp, accuracy: accuracy, typeId: typeId, moveDamageClassId: moveDamageClassId, moveName: name))
            }
            sqlite3_finalize(stmt)
        }
        return moves
    }
}
