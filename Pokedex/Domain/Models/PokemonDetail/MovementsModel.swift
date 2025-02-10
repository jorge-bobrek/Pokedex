//
//  MovementsModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 25/04/24.
//

struct PokemonMove: Identifiable, Decodable, Hashable {
    let id: Int
    let level: Int
    let versionGroupId: Int
    let power: Int?
    let pp: Int
    let accuracy: Int?
    let typeId: Int
    let moveDamageClassId: Int
    let name: [LanguageModel]
    
    static let template = PokemonMove(id: 144, level: 1, versionGroupId: 8, power: nil, pp: 10, accuracy: nil, typeId: 1, moveDamageClassId: 1, name: [LanguageModel(id: 9, name: "Transform")])
}
