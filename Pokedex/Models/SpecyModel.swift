//
//  SpeciesDataModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SchemaAPI

struct Specy: Decodable, Identifiable {
    let id: Int
    let generation: Int
    let names: [LanguageModel]
    let sprite: String
    static let template = Specy(id: 133, generation: 1, names: [LanguageModel(id: 7, name: "eevee")], sprite: Bundle.main.getSprite(for: 133)/*, generation: 1*/)
}
