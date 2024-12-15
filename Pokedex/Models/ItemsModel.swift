//
//  ItemsModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/03/23.
//

struct ItemsResponse: Decodable {
    let pokemonItem: [Item]

    enum CodingKeys: String, CodingKey {
        case pokemonItem = "pokemon_v2_item"
    }
}

struct Item: Identifiable, Decodable {
    let id: Int
    let category: ItemCategory
    let names: [LanguageModel]

    enum CodingKeys: String, CodingKey {
        case id
        case category = "pokemon_v2_itemcategory"
        case names = "pokemon_v2_itemnames"
    }
}

struct ItemCategory: Decodable {
    let itemPocketID: Int

    enum CodingKeys: String, CodingKey {
        case itemPocketID = "item_pocket_id"
    }
}
