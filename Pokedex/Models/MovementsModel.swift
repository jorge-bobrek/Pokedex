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
    let power: Int
    let pp: Int
    let accuracy: Int
    let typeId: Int
    let moveDamageClassId: Int
    let moveName: String
}
