//
//  ItemsModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/03/23.
//

struct Item: Identifiable, Decodable {
    let id: Int
    let itemPocketId: Int
    let name: String
    let names: [LanguageModel]
    let flavor: [LanguageModel]

    enum CodingKeys: String, CodingKey {
        case id = "itemId"
        case itemPocketId, name, names, flavor
    }
}
