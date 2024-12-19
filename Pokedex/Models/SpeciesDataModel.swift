//
//  SpeciesDataModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

struct Species: Identifiable, Decodable, Equatable {
    let id: Int
    let generationId: Int
    let name: String

    static let template = Species(id: 133, generationId: 1, name: "Eevee")
}

struct SpeciesChain: Decodable, Identifiable {
    let id: Int
    let evolvesFromSpeciesId: Int?
}
