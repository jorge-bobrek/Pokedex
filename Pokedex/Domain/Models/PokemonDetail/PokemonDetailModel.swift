//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/03/23.
//

struct PokemonDetail: Decodable, Identifiable {
    let id: Int
    let height: Int
    let weight: Int
    let pokemonTypes: [PokemonType]
    let pokemonAbilities: [PokemonAbility]
    let pokemonStats: [PokemonStat]
    let pokemonMoves: [PokemonMove]
    let pokemonForms: [PokemonForm]
    
    static let pikachu = PokemonDetail(id: 24, height: 4, weight: 60, pokemonTypes: [PokemonType(id: 13, typeName: [LanguageModel(id: 9, name: "Electric")])], pokemonAbilities: [PokemonAbility(id: 9, isHidden: false, name: [LanguageModel(id: 9, name: "Static")], flavor: [LanguageModel(id: 9, name: "The Pokémon is charged with static electricity, so contact with it may cause paralysis.")]), PokemonAbility(id: 31, isHidden: true, name: [LanguageModel(id: 9, name: "Lightning Rod")], flavor: [LanguageModel(id: 9, name: "The Pokémon draws in all Electric-type moves. Instead of being hit by Electric-type moves, it boosts its Sp. Atk.")])], pokemonStats: [PokemonStat(id: 1, stat: 35), PokemonStat(id: 1, stat: 55), PokemonStat(id: 3, stat: 40), PokemonStat(id: 4, stat: 50), PokemonStat(id: 5, stat: 50), PokemonStat(id: 6, stat: 90)], pokemonMoves: [.template], pokemonForms: [PokemonForm(id: 10368, name: "gmax", names: [LanguageModel(id: 9, name: "Gigantamax Form")])])
    
    static let mew = PokemonDetail(id: 151, height: 4, weight: 40, pokemonTypes: [PokemonType(id: 14, typeName: [LanguageModel(id: 9, name: "Psychic")])], pokemonAbilities: [PokemonAbility(id: 28, isHidden: false, name: [LanguageModel(id: 9, name: "Synchronize")], flavor: [LanguageModel(id: 9, name: "The attacker will receive the same status condition if it inflicts a burn, poison, or paralysis to the Pokémon.")])], pokemonStats: [PokemonStat(id: 1, stat: 100), PokemonStat(id: 1, stat: 100), PokemonStat(id: 3, stat: 100), PokemonStat(id: 4, stat: 100), PokemonStat(id: 5, stat: 100), PokemonStat(id: 6, stat: 100)], pokemonMoves: [.template], pokemonForms: [])
}

