//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/03/23.
//

struct PokemonSpecies: Decodable, Identifiable {
    let id: Int
    let name: String
    let genderRate: Int
    let hasGenderDifferences: Bool
    let evolutionChainId: Int
    let evolvesFromSpeciesId: Int
    let generationId: Int
    let speciesName: String
    let colorName: String
    let eggGroups: [EggGroup]
    let pokemons: [PokemonDetail]
    
    static let template = PokemonSpecies(id: 133, name: "eevee", genderRate: 1, hasGenderDifferences: true, evolutionChainId: 67, evolvesFromSpeciesId: 0, generationId: 1, speciesName: "Eevee", colorName: "Marrón", eggGroups: [EggGroup(id: 1, name: "Campo")], pokemons: [PokemonDetail.template])
}

struct PokemonDetail: Decodable, Identifiable {
    let id: Int
    let height: Int
    let weight: Int
    let pokemonTypes: [PokemonType]
    let pokemonAbilities: [PokemonAbility]
    let pokemonStats: [PokemonStat]
    let pokemonMoves: [PokemonMove]
    let pokemonForms: [PokemonForm]
    
    static let template = PokemonDetail(id: 133, height: 3, weight: 65, pokemonTypes: [PokemonType(id: 1, typeName: "Normal")], pokemonAbilities: [PokemonAbility(id: 351, isHidden: false, name: "Fuga", flavor: ""), PokemonAbility(id: 352, isHidden: false, name: "Adaptable", flavor: ""),  PokemonAbility(id: 353, isHidden: true, name: "Anticipación", flavor: "")], pokemonStats: [PokemonStat(id: 1, stat: 55), PokemonStat(id: 2, stat: 55), PokemonStat(id: 3, stat: 50), PokemonStat(id: 4, stat: 45), PokemonStat(id: 5, stat: 65), PokemonStat(id: 6, stat: 55)], pokemonMoves: [], pokemonForms: [])
}

struct PokemonType: Decodable, Identifiable {
    let id: Int
    let typeName: String
}

struct PokemonAbility: Decodable, Identifiable {
    let id: Int
    let isHidden: Bool
    let name: String
    let flavor: String
}

struct PokemonStat: Decodable, Identifiable {
    let id: Int
    let stat: Int
}

struct PokemonForm: Decodable, Identifiable {
    let id: Int
    let formName: String
    let flavor: String
}

struct EggGroup: Decodable, Identifiable {
    let id: Int
    let name: String
}
