//
//  SpeciesRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

import Foundation
import SQLite3

class SpeciesRepository {
    let dbHelper = DatabaseHelper.shared

    // Consulta para obtener todas las especies
    func getAllSpecies() -> [Species] {
        let query = """
            SELECT p.pokemon_id, p.generation, pn.language_id, pn.name
            FROM pokemon_v2_pokemonspecy p
            LEFT JOIN pokemon_v2_pokemonspeciesnames pn ON p.pokemon_id = pn.pokemon_id;
        """
        var speciesDict: [Int: Species] = [:]

        if let stmt = dbHelper.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let speciesId = sqlite3_column_int(stmt, 0)
                let generation = sqlite3_column_int(stmt, 1)
                let languageId = sqlite3_column_int(stmt, 2)
                let name = String(cString: sqlite3_column_text(stmt, 3))
                
                let lang = LanguageModel(id: Int(languageId), name: name)

                if let species = speciesDict[Int(speciesId)] {
                    let newSpecies = Species(id: species.id, generationId: Int(generation), evolvesFromSpeciesId: nil, names: species.names + [lang])
                    speciesDict[Int(speciesId)] = newSpecies
                } else {
                    let newSpecies = Species(id: Int(speciesId), generationId: Int(generation), evolvesFromSpeciesId: nil, names: [lang])
                    speciesDict[Int(speciesId)] = newSpecies
                }
            }
            sqlite3_finalize(stmt)
        }
        return speciesDict.values.sorted( by: { $0.id < $1.id })
    }
}
