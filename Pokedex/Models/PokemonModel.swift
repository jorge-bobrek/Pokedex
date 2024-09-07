//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/03/23.
//

import Foundation
import SchemaAPI

typealias PokemonData = GetDetailQuery.Data.Pokemon_v2_pokemon

struct Pokemon: Decodable {
    let id: Int
    let specy: DetailSpecy
    let abilities: [DetailAbility]
    let types: [DetailLanguageItem]
    let cry: String?
    
    init(_ pokemon: PokemonData) {
        self.id = pokemon.id
        self.specy = DetailSpecy(pokemon.pokemon_v2_pokemonspecy)
        self.abilities = pokemon.pokemon_v2_pokemonabilities.map { ability in
            DetailAbility(ability)
        }
        self.types = pokemon.pokemon_v2_pokemontypes.map({ type in
            let id = type.pokemon_v2_type?.id
            let names = type.pokemon_v2_type?.pokemon_v2_typenames.map({ name in
                LanguageModel(id: name.language_id, name: name.name)
            })
            return DetailLanguageItem(id: id, names: names)
        })
        self.cry = pokemon.pokemon_v2_pokemoncries.first?.cries
    }
    
    init(id: Int, specy: DetailSpecy, abilities: [DetailAbility], types: [DetailLanguageItem], cry: String?) {
        self.id = id
        self.specy = specy
        self.abilities = abilities
        self.types = types
        self.cry = cry
    }
    
    struct DetailSpecy: Decodable {
        let genderRate: Int?
        let captureRate: Int?
        let hatchCounter: Int?
        let evolutionChain: Int?
        let names: [LanguageModel]?
        let color: DetailLanguageItem?
        let generation: Int?
        
        init(_ specy: PokemonData.Pokemon_v2_pokemonspecy?) {
            self.genderRate = specy?.gender_rate
            self.captureRate = specy?.capture_rate
            self.hatchCounter = specy?.hatch_counter
            self.evolutionChain = specy?.evolution_chain_id
            self.names = specy?.pokemon_v2_pokemonspeciesnames.map({ name in
                LanguageModel(id: name.language_id, name: name.name)
            })
            self.color = DetailLanguageItem(id: specy?.pokemon_v2_pokemoncolor?.id, names: specy?.pokemon_v2_pokemoncolor?.pokemon_v2_pokemoncolornames.map({ name in
                LanguageModel(id: name.language_id, name: name.name)
            }))
            self.generation = specy?.pokemon_v2_generation?.id
        }
        
        init(genderRate: Int?, captureRate: Int?, hatchCounter: Int?, evolutionChain: Int?, names: [LanguageModel]?, color: DetailLanguageItem?, generation: Int?) {
            self.genderRate = genderRate
            self.captureRate = captureRate
            self.hatchCounter = hatchCounter
            self.evolutionChain = evolutionChain
            self.names = names
            self.color = color
            self.generation = generation
        }
    }
    
    struct DetailAbility: Decodable, Identifiable {
        let id: Int
        let isHidden: Bool
        let names: [LanguageModel]
        
        init(_ ability: PokemonData.Pokemon_v2_pokemonability) {
            self.id = ability.id
            self.isHidden = ability.is_hidden
            self.names = ability.pokemon_v2_ability?.pokemon_v2_abilitynames.map({ name in
                LanguageModel(id: name.language_id, name: name.name)
            }) ?? []
        }
        
        init(id: Int, isHidden: Bool, names: [LanguageModel]) {
            self.id = id
            self.isHidden = isHidden
            self.names = names
        }
    }
    
    struct DetailLanguageItem: Decodable, Identifiable {
        let id: Int?
        let names: [LanguageModel]?
        
        init(id: Int?, names: [LanguageModel]?) {
            self.id = id
            self.names = names
        }
    }
    
    static let template = 
    Pokemon(
        id: 133,
        specy: DetailSpecy(
            genderRate: 1,
            captureRate: 45,
            hatchCounter: 35,
            evolutionChain: 67,
            names: [
                LanguageModel(id: 7, name: "Eevee")
            ],
            color: DetailLanguageItem(
                id: 3,
                names: [
                    LanguageModel(id: 7, name: "Marrón")
                ]),
            generation: 1),
        abilities: [
            DetailAbility(
                id: 351,
                isHidden: false,
                names: [
                    LanguageModel(id: 7, name: "Fuga")
                ]),
            DetailAbility(
                id: 352,
                isHidden: false, 
                names: [
                    LanguageModel(id: 7, name: "Adaptable")
                ]),
            DetailAbility(
                id: 353,
                isHidden: true,
                names: [
                    LanguageModel(id: 7, name: "Anticipación")
                ])
        ],
        types: [
            DetailLanguageItem(
                id: 1,
                names: [
                    LanguageModel(id: 7, name: "Normal")
                ])
        ],
        cry: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/133.ogg")
}
