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
            SELECT p.pokemon_id, p.evolves_from_species_id
            FROM pokemon_v2_pokemonspecy p
            WHERE p.evolution_chain_id = \(chainId);
        """
        var species = [SpeciesChain]()

        if let stmt = DatabaseHelper.shared.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let pokemonId = Int(sqlite3_column_int(stmt, 0))
                let evolvesfromSpeciesId = Int(sqlite3_column_int(stmt, 1))
                
                species.append(SpeciesChain(id: pokemonId, evolvesFromSpeciesId: evolvesfromSpeciesId))
            }
            sqlite3_finalize(stmt)
        }
        return species
    }
}
