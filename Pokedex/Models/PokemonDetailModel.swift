//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 29/03/23.
//

struct PokemonDetail: Identifiable, Decodable {
    let id: Int
    let species: PokemonSpecies
    let abilities: [PokemonAbility]
    let types: [PokemonType]
    let stats: [PokemonStat]
    
    static let template = PokemonDetail(
        id: 133,
        species: PokemonSpecies(
            genderRate: 1,
            evolutionChainId: 67,
            speciesName: "Eevee",
            color: "Marrón",
            generation: 1
        ),
        abilities: [
            PokemonAbility(
                id: 351,
                name: "Fuga",
                isHidden: false
            ),
            PokemonAbility(
                id: 352,
                name: "Adaptable",
                isHidden: false
            ),
            PokemonAbility(
                id: 353,
                name: "Anticipación",
                isHidden: true
            )
        ],
        types: [
            PokemonType(
                id: 1,
                typeName: "Normal"
            )
        ], stats: [
            PokemonStat(id: 1, stat: 55),
            PokemonStat(id: 2, stat: 55),
            PokemonStat(id: 3, stat: 50),
            PokemonStat(id: 4, stat: 45),
            PokemonStat(id: 5, stat: 65),
            PokemonStat(id: 6, stat: 55)
        ]
    )
     
}
struct PokemonSpecies: Decodable {
    let genderRate: Int
    let evolutionChainId: Int?
    let speciesName: String
    let color: String
    let generation: Int
}

struct PokemonAbility: Decodable {
    let id: Int
    let name: String
    let isHidden: Bool
}

struct PokemonStat: Decodable, Identifiable {
    let id: Int
    let stat: Int
}

struct PokemonType: Decodable, Identifiable {
    let id: Int
    let typeName: String
}

struct Generation: Decodable {
    let id: Int
}
