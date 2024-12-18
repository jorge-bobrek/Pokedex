//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

import Foundation
import SQLite3

class PokemonRepository {
    func getPokemon(id: Int, language: Language) -> PokemonDetail? {
        let query = """
            SELECT p.pokemon_id, p.gender_rate, p.evolution_chain_id, p.generation,
                   pn.name AS species_name, pc.name AS color_name,
                   GROUP_CONCAT(DISTINCT pa.ability_id || ':' || an.name || ':' || pa.is_hidden) AS abilities,
                   GROUP_CONCAT(DISTINCT pt.type_id || ':' || tn.name) AS types,
                   GROUP_CONCAT(DISTINCT ps.stat_id || ':' || ps.base_stat) AS stats
            FROM pokemon_v2_pokemonspecy p
            LEFT JOIN pokemon_v2_pokemonspeciesnames pn ON p.pokemon_id = pn.pokemon_id
            LEFT JOIN pokemon_v2_pokemoncolornames pc ON p.color = pc.color_id
            LEFT JOIN pokemon_v2_pokemonstats ps ON p.pokemon_id = ps.pokemon_id
            LEFT JOIN pokemon_v2_pokemonabilities pa ON p.pokemon_id = pa.pokemon_id
            LEFT JOIN pokemon_v2_abilitynames an ON pa.ability_id = an.ability_id
            LEFT JOIN pokemon_v2_pokemontypes pt ON p.pokemon_id = pt.pokemon_id
            LEFT JOIN pokemon_v2_typenames tn ON pt.type_id = tn.type_id
            WHERE p.pokemon_id = \(id)
                and pn.language_id = \(language.rawValue)
                and pc.language_id = \(language.rawValue)
                and an.language_id = \(language.rawValue)
                and tn.language_id = \(language.rawValue)
            GROUP BY p.pokemon_id, pn.name, pc.name;
        """
        var pokemon: PokemonDetail?
        if let stmt = DatabaseHelper.shared.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let pokemon_id = Int(sqlite3_column_int(stmt, 0))
                let gender_rate = Int(sqlite3_column_int(stmt, 1))
                let evolution_chain_id = Int(sqlite3_column_int(stmt, 2))
                let generation = Int(sqlite3_column_int(stmt, 3))
                let species_name = String(cString: sqlite3_column_text(stmt, 4))
                let color_name = String(cString: sqlite3_column_text(stmt, 5))
                
                var pokemon_abilities = [PokemonAbility]()
                for ability_data in String(cString: sqlite3_column_text(stmt, 6)).split(separator: ",") {
                    let data = ability_data.split(separator: ":")
                    pokemon_abilities.append(PokemonAbility(id: Int(data[0])!, name: String(data[1]), isHidden: Int(data[2]) == 1))
                }
                var pokemon_types = [PokemonType]()
                for type_data in String(cString: sqlite3_column_text(stmt, 7)).split(separator: ",") {
                    let data = type_data.split(separator: ":")
                    pokemon_types.append(PokemonType(id: Int(data[0])!, typeName: String(data[1])))
                }
                var pokemon_stats = [PokemonStat]()
                for stat_data in String(cString: sqlite3_column_text(stmt, 8)).split(separator: ",") {
                    let data = stat_data.split(separator: ":")
                    pokemon_stats.append(PokemonStat(id: Int(data[0])!, stat:Int(data[1])!))
                }
                
                pokemon = PokemonDetail(id: pokemon_id, species: PokemonSpecies(genderRate: gender_rate, evolutionChainId: evolution_chain_id, speciesName: species_name, color: color_name, generation: generation), abilities: pokemon_abilities, types: pokemon_types, stats: pokemon_stats)
            }
            sqlite3_finalize(stmt)
        }
        return pokemon
    }
}

