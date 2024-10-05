//
//  NaturesDataModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

import Foundation

struct NaturesResponse: Decodable {
    let natures: [Nature]
    
    enum CodingKeys: String, CodingKey {
        case natures = "pokemon_v2_nature"
    }
}

struct Nature: Identifiable, Decodable {
    let id: Int
    let names: [LanguageModel]
    let increased: Int?
    let decreased: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case names = "pokemon_v2_naturenames"
        case increased = "increased_stat_id"
        case decreased = "decreased_stat_id"
    }
}
