//
//  SpeciesRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

import Foundation
import SQLite3

class SpeciesRepository {
    func getAllSpecies(_ language: Language) -> [Species] {
        let query = """
            SELECT p.pokemon_id, p.generation, pn.name
            FROM pokemon_v2_pokemonspecy p
            LEFT JOIN pokemon_v2_pokemonspeciesnames pn ON p.pokemon_id = pn.pokemon_id
            WHERE pn.language_id = \(language.rawValue)
        """
        var species = [Species]()

        if let stmt = DatabaseHelper.shared.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let speciesId = Int(sqlite3_column_int(stmt, 0))
                let generation = Int(sqlite3_column_int(stmt, 1))
                let name = String(cString: sqlite3_column_text(stmt, 2))
                
                species.append(Species(id: speciesId, generationId: generation, evolvesFromSpeciesId: nil, name: name))
            }
            sqlite3_finalize(stmt)
        }
        return species
    }
}
