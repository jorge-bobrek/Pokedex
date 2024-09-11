//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/03/23.
//

struct PokemonDetailResponse: Decodable {
    let pokemonDetails: [PokemonDetail]
    
    enum CodingKeys: String, CodingKey {
        case pokemonDetails = "pokemon_v2_pokemon"
    }
}

struct PokemonDetail: Identifiable, Decodable {
    let id: Int
    let species: PokemonSpecies
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    let cries: [PokemonCry]
    
    enum CodingKeys: String, CodingKey {
        case id
        case species = "pokemon_v2_pokemonspecy"
        case abilities = "pokemon_v2_pokemonabilities"
        case types = "pokemon_v2_pokemontypes"
        case cries = "pokemon_v2_pokemoncries"
    }
    static let template =
    PokemonDetail(
        id: 133,
        species: PokemonSpecies(
            genderRate: 1,
            captureRate: 45,
            hatchCounter: 35,
            evolutionChainId: 67,
            speciesNames: [
                LanguageModel(id: 7, name: "Eevee")
            ],
            color: PokemonColor(
                id: 3,
                colorNames: [
                    LanguageModel(id: 7, name: "Marrón")
                ]
            ),
            growthRate: LanguageModel(id: 0, name: ""),
            generation: Generation(id: 1)
        ),
        abilities: [
            PokemonAbility(
                id: 351,
                isHidden: false,
                ability: AbilityDetail(abilityNames: [
                    LanguageModel(id: 7, name: "Fuga")
                ])
            ),
            PokemonAbility(
                id: 352,
                isHidden: false,
                ability: AbilityDetail(abilityNames: [
                    LanguageModel(id: 7, name: "Adaptable")
                ])
            ),
            PokemonAbility(
                id: 353,
                isHidden: true,
                ability: AbilityDetail(abilityNames: [
                    LanguageModel(id: 7, name: "Anticipación")
                ])
            )
        ],
        types: [
            PokemonType(
                type: TypeDetail(
                    id: 1,
                    typeNames: [
                        LanguageModel(id: 7, name: "Normal")
                    ]
                )
            )
        ],
        cries: [
            PokemonCry(cries: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/133.ogg")
        ]
    )
}
struct PokemonSpecies: Decodable {
    let genderRate: Int
    let captureRate: Int
    let hatchCounter: Int?
    let evolutionChainId: Int?
    let speciesNames: [LanguageModel]
    let color: PokemonColor
    let growthRate: LanguageModel
    let generation: Generation
    
    enum CodingKeys: String, CodingKey {
        case genderRate = "gender_rate"
        case captureRate = "capture_rate"
        case hatchCounter = "hatch_counter"
        case evolutionChainId = "evolution_chain_id"
        case speciesNames = "pokemon_v2_pokemonspeciesnames"
        case color = "pokemon_v2_pokemoncolor"
        case growthRate = "pokemon_v2_growthrate"
        case generation = "pokemon_v2_generation"
    }
}

struct PokemonAbility: Decodable {
    let id: Int
    let isHidden: Bool
    let ability: AbilityDetail
    
    enum CodingKeys: String, CodingKey {
        case id
        case isHidden = "is_hidden"
        case ability = "pokemon_v2_ability"
    }
}

struct AbilityDetail: Decodable {
    let abilityNames: [LanguageModel]
    
    enum CodingKeys: String, CodingKey {
        case abilityNames = "pokemon_v2_abilitynames"
    }
}

struct PokemonType: Decodable {
    let type: TypeDetail
    
    enum CodingKeys: String, CodingKey {
        case type = "pokemon_v2_type"
    }
}

struct TypeDetail: Decodable {
    let id: Int
    let typeNames: [LanguageModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case typeNames = "pokemon_v2_typenames"
    }
}

struct PokemonCry: Decodable {
    let cries: String
}

struct PokemonColor: Decodable {
    let id: Int
    let colorNames: [LanguageModel]
    
    enum CodingKeys: String, CodingKey {
        case id
        case colorNames = "pokemon_v2_pokemoncolornames"
    }
}

struct Generation: Decodable {
    let id: Int
}
