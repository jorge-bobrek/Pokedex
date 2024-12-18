//
//  SpeciesDataModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

struct Species: Identifiable, Decodable, Equatable {
    let id: Int
    let generationId: Int
    let evolvesFromSpeciesId: Int?
    let name: String

    static let template = Species(id: 133, generationId: 1, evolvesFromSpeciesId: nil, name: "Eevee")
}
