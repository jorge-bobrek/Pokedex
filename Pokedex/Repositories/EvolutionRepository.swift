//
//  EvolutionRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 18/12/24.
//

import Foundation
import SQLite3

class EvolutionRepository {
    func getEvolutionChain(forChainId chainId: Int) -> [SpeciesChain] {
        let query = """
            SELECT p.species_id, p.evolves_from_species_id, p.name
            FROM pokemon_v2_pokemonspecy p
            WHERE p.evolution_chain_id = \(chainId);
        """
        var species = [SpeciesChain]()

        if let stmt = DatabaseHelper.shared.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let pokemonId = Int(sqlite3_column_int(stmt, 0))
                let evolvesfromSpeciesId = Int(sqlite3_column_int(stmt, 1))
                let name = String(cString: sqlite3_column_text(stmt, 2))
                
                species.append(SpeciesChain(id: pokemonId, evolvesFromSpeciesId: evolvesfromSpeciesId, name: name))
            }
            sqlite3_finalize(stmt)
        }
        return species
    }
}
