//
//  NaturesDataModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

struct NaturesModel: Decodable {
    let natures: [Nature]
}

struct Nature: Identifiable, Decodable {
    let id: Int
    let names: [LanguageModel]
    let increased: Int?
    let decreased: Int?
}
