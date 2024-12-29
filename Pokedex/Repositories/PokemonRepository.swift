//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

import Foundation
import SQLite3

class PokemonRepository {
    func getPokemon(id: Int, language: Language) -> PokemonSpecies? {
        let query = """
            SELECT p.species_id, p.name, p.gender_rate, p.has_gender_differences, p.evolution_chain_id, p.evolves_from_species_id, p.generation_id, pn.name, pc.name, egg_groups
            FROM pokemon_v2_pokemonspecy p
            LEFT JOIN pokemon_v2_pokemonspeciesnames pn ON p.species_id = pn.species_id
            LEFT JOIN pokemon_v2_pokemoncolornames pc ON p.color_id = pc.color_id
            LEFT JOIN (
                SELECT eg.species_id, GROUP_CONCAT(gn.egggroup_id || ':' || gn.name, '|') AS egg_groups
                FROM pokemon_v2_pokemonegggroups eg
                LEFT JOIN pokemon_v2_egggroupnames gn ON eg.egggroup_id = gn.egggroup_id AND gn.language_id = \(language.rawValue)
                GROUP BY eg.species_id
            ) eggs ON eggs.species_id = p.species_id
            WHERE p.species_id = \(id) and pn.language_id = \(language.rawValue) and pc.language_id = \(language.rawValue);
        """
        var pokemon: PokemonSpecies?
        if let stmt = DatabaseHelper.shared.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let pokemonId = Int(sqlite3_column_int(stmt, 0))
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let genderRate = Int(sqlite3_column_int(stmt, 2))
                let hasGenderDifferences = Int(sqlite3_column_int(stmt, 3))
                let evolutionChainId = Int(sqlite3_column_int(stmt, 4))
                let evolvesFromSpeciesId = Int(sqlite3_column_int(stmt, 5))
                let generationId = Int(sqlite3_column_int(stmt, 6))
                let speciesName = String(cString: sqlite3_column_text(stmt, 7))
                let colorName = String(cString: sqlite3_column_text(stmt, 8))
                
                var eggGroups = [EggGroup]()
                for groupsData in String(cString: sqlite3_column_text(stmt, 9)).split(separator: "|") {
                    let data = groupsData.split(separator: ":")
                    eggGroups.append(EggGroup(id: Int(data[0])!, name: String(data[1])))
                }
                
                let pokemons = self.getPokemonForms(id: id, language: language)
                
                pokemon = PokemonSpecies(id: pokemonId, name: name, genderRate: genderRate, hasGenderDifferences: hasGenderDifferences == 1, evolutionChainId: evolutionChainId, evolvesFromSpeciesId: evolvesFromSpeciesId, generationId: generationId, speciesName: speciesName, colorName: colorName, eggGroups: eggGroups, pokemons: pokemons)
            }
            sqlite3_finalize(stmt)
        }
        return pokemon
    }
    
    private func getPokemonForms(id: Int, language: Language) -> [PokemonDetail] {
        let query = """
            SELECT p.pokemon_id, p.height, p.weight,
                   GROUP_CONCAT(types.types_combined, '|') AS types,
                   GROUP_CONCAT(abilities.abilities_combined, '|') AS abilities,
                   GROUP_CONCAT(stats.stats_combined, '|') AS stats,
                   GROUP_CONCAT(forms.forms_combined, '|') AS forms
            FROM pokemon_v2_pokemonspecy ps
            LEFT JOIN pokemon_v2_pokemons p ON ps.species_id = p.species_id
            LEFT JOIN (
                SELECT pt.pokemon_id, GROUP_CONCAT(pt.type_id || ':' || tn.name, '|') AS types_combined
                FROM pokemon_v2_pokemontypes pt
                LEFT JOIN pokemon_v2_typenames tn ON pt.type_id = tn.type_id AND tn.language_id = \(language.rawValue)
                GROUP BY pt.pokemon_id
            ) types ON types.pokemon_id = p.pokemon_id
            LEFT JOIN (
                SELECT pa.pokemon_id, GROUP_CONCAT(pa.ability_id || ':' || pa.is_hidden || ':' || an.name || ':' || af.flavor_text, '|') AS abilities_combined
                FROM pokemon_v2_pokemonabilities pa
                LEFT JOIN pokemon_v2_abilitynames an ON pa.ability_id = an.ability_id AND an.language_id = \(language.rawValue)
                LEFT JOIN pokemon_v2_abilityflavortexts af ON pa.ability_id = af.ability_id AND af.language_id = \(language.rawValue)
                GROUP BY pa.pokemon_id
            ) abilities ON abilities.pokemon_id = p.pokemon_id
            LEFT JOIN (
                SELECT st.pokemon_id, GROUP_CONCAT(st.stat_id || ':' || st.base_stat, '|') AS stats_combined
                FROM pokemon_v2_pokemonstats st
                GROUP BY st.pokemon_id
            ) stats ON stats.pokemon_id = p.pokemon_id
            LEFT JOIN (
                SELECT pf.pokemon_id, GROUP_CONCAT(pf.form_id || ':' || pf.form_name || ':' || fn.name, '|') AS forms_combined
                FROM pokemon_v2_pokemonforms pf
                LEFT JOIN pokemon_v2_pokemonformnames fn ON pf.form_id = fn.form_id AND fn.language_id = \(language.rawValue)
                GROUP BY pf.pokemon_id
            ) forms ON forms.pokemon_id = p.pokemon_id
            WHERE p.species_id = \(id)
            GROUP BY p.pokemon_id;
        """
        var pokemons = [PokemonDetail]()
        if let stmt = DatabaseHelper.shared.executeQuery(query: query) {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let pokemonId = Int(sqlite3_column_int(stmt, 0))
                let height = Int(sqlite3_column_int(stmt, 1))
                let weight = Int(sqlite3_column_int(stmt, 2))
                
                var pokemonTypes = [PokemonType]()
                for typeData in String(cString: sqlite3_column_text(stmt, 3)).split(separator: "|") {
                    let data = typeData.split(separator: ":")
                    pokemonTypes.append(PokemonType(id: Int(data[0])!, typeName: String(data[1])))
                }
                var pokemonAbilities = [PokemonAbility]()
                for abilityData in String(cString: sqlite3_column_text(stmt, 4)).split(separator: "|") {
                    let data = abilityData.split(separator: ":")
                    pokemonAbilities.append(PokemonAbility(id: Int(data[0])!, isHidden: Int(data[1]) == 1, name: String(data[2]), flavor: String(data[3])))
                }
                var pokemonStats = [PokemonStat]()
                for statData in String(cString: sqlite3_column_text(stmt, 5)).split(separator: "|") {
                    let data = statData.split(separator: ":")
                    pokemonStats.append(PokemonStat(id: Int(data[0])!, stat:Int(data[1])!))
                }
                var pokemonForms = [PokemonForm]()
                if let forms = sqlite3_column_text(stmt, 6) {
                    for formData in String(cString: forms).split(separator: "|") {
                        let data = formData.components(separatedBy: ":")
                        pokemonForms.append(PokemonForm(id: Int(data[0])!, formName: String(data[1]), flavor: String(data[2])))
                    }
                }
                let pokemonMoves: [PokemonMove] = self.getAllMoves(forPokemonId: pokemonId, language)
                
                pokemons.append(PokemonDetail(id: pokemonId, height: height, weight: weight, pokemonTypes: pokemonTypes, pokemonAbilities: pokemonAbilities, pokemonStats: pokemonStats, pokemonMoves: pokemonMoves, pokemonForms: pokemonForms))
            }
            sqlite3_finalize(stmt)
        }
        return pokemons
    }
    
    private func getAllMoves(forPokemonId pokemonId: Int,_ language: Language) -> [PokemonMove] {
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

