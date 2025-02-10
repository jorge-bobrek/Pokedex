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
    
    static let template = PokemonDetail(id: 151, height: 4, weight: 40, pokemonTypes: [PokemonType(id: 14, typeName: [LanguageModel(id: 9, name: "Psychic")])], pokemonAbilities: [PokemonAbility(id: 28, isHidden: false, name: [LanguageModel(id: 9, name: "Synchronize")], flavor: [LanguageModel(id: 9, name: "The attacker will receive the same status condition if it inflicts a burn, poison, or paralysis to the Pokémon.")])], pokemonStats: [PokemonStat(id: 1, stat: 100), PokemonStat(id: 1, stat: 100), PokemonStat(id: 3, stat: 100), PokemonStat(id: 4, stat: 100), PokemonStat(id: 5, stat: 100), PokemonStat(id: 6, stat: 100)], pokemonMoves: [.template], pokemonForms: [])
}

