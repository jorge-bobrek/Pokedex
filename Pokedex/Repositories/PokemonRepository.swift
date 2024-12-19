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
            SELECT p.pokemon_id, p.gender_rate, p.evolution_chain_id, p.generation_id,
                   pn.name AS species_name, pc.name AS color_name,
                   GROUP_CONCAT(DISTINCT pa.ability_id || ':' || an.name || ':' || pa.is_hidden) AS abilities,
                   GROUP_CONCAT(DISTINCT pt.type_id || ':' || tn.name) AS types,
                   GROUP_CONCAT(DISTINCT ps.stat_id || ':' || ps.base_stat) AS stats
            FROM pokemon_v2_pokemonspecy p
            LEFT JOIN pokemon_v2_pokemonspeciesnames pn ON p.pokemon_id = pn.pokemon_id
            LEFT JOIN pokemon_v2_pokemoncolornames pc ON p.color_id = pc.color_id
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
                let pokemonId = Int(sqlite3_column_int(stmt, 0))
                let genderRate = Int(sqlite3_column_int(stmt, 1))
                let evolutionChainId = Int(sqlite3_column_int(stmt, 2))
                let generation = Int(sqlite3_column_int(stmt, 3))
                let species_name = String(cString: sqlite3_column_text(stmt, 4))
                let colorName = String(cString: sqlite3_column_text(stmt, 5))
                
                var pokemonAbilities = [PokemonAbility]()
                for abilityData in String(cString: sqlite3_column_text(stmt, 6)).split(separator: ",") {
                    let data = abilityData.split(separator: ":")
                    pokemonAbilities.append(PokemonAbility(id: Int(data[0])!, name: String(data[1]), isHidden: Int(data[2]) == 1))
                }
                var pokemonTypes = [PokemonType]()
                for typeData in String(cString: sqlite3_column_text(stmt, 7)).split(separator: ",") {
                    let data = typeData.split(separator: ":")
                    pokemonTypes.append(PokemonType(id: Int(data[0])!, typeName: String(data[1])))
                }
                var pokemonStats = [PokemonStat]()
                for statData in String(cString: sqlite3_column_text(stmt, 8)).split(separator: ",") {
                    let data = statData.split(separator: ":")
                    pokemonStats.append(PokemonStat(id: Int(data[0])!, stat:Int(data[1])!))
                }
                
                pokemon = PokemonDetail(id: pokemonId, species: PokemonSpecies(genderRate: genderRate, evolutionChainId: evolutionChainId, speciesName: species_name, color: colorName, generation: generation), abilities: pokemonAbilities, types: pokemonTypes, stats: pokemonStats)
            }
            sqlite3_finalize(stmt)
        }
        return pokemon
    }
}

