//
//  DatabaseManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

import Foundation
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    var db: OpaquePointer?

    private init() {
        openDatabase()
    }
    deinit {
        closeDatabase()
    }
    
    func openDatabase() {
        guard let bundleURL = Bundle.main.url(forResource: "pokemon", withExtension: "db") else {
            print("DBError fileNotFound")
            return
        }
        if sqlite3_open_v2(bundleURL.path, &db, SQLITE_OPEN_READONLY, nil) == SQLITE_OK {
            print("Base de datos abierta exitosamente en \(bundleURL.path)")
        } else {
            print("Error al abrir la base de datos.")
        }
    }

    func closeDatabase() {
        if sqlite3_close(db) != SQLITE_OK {
            print("Error al cerrar la base de datos.")
        }
    }

    func getAllPokemons() -> [Species] {
        let query = """
            SELECT p.pokemon_id, p.generation, pn.language_id, pn.name
            FROM pokemon_v2_pokemonspecy p
            LEFT JOIN pokemon_v2_pokemonspeciesnames pn ON p.pokemon_id = pn.pokemon_id;
        """
        
        var stmt: OpaquePointer?
        var speciesDict: [Int: Species] = [:]

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let speciesId = sqlite3_column_int(stmt, 0)
                let generation = sqlite3_column_int(stmt, 1)
                let languageId = sqlite3_column_int(stmt, 2)
                let name = String(cString: sqlite3_column_text(stmt, 3))
                
                let lang = LanguageModel(id: Int(languageId), name: name)

                // Aquí no modificamos las especies existentes, creamos una nueva especie con el idioma añadido
                if let species = speciesDict[Int(speciesId)] {
                    let newSpecies = Species(id: species.id, generationId: Int(generation), evolvesFromSpeciesId: nil, names: species.names + [lang])
                    speciesDict[Int(speciesId)] = newSpecies
                } else {
                    let newSpecies = Species(id: Int(speciesId), generationId: Int(generation), evolvesFromSpeciesId: nil, names: [lang])
                    speciesDict[Int(speciesId)] = newSpecies
                }
            }
        } else {
            print("Error al preparar la consulta.")
        }

        sqlite3_finalize(stmt)

        return speciesDict.values.sorted( by: { $0.id < $1.id })
    }
}
