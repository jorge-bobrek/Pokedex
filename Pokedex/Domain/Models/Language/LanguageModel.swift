//
//  LanguageModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/04/24.
//

struct LanguageModel: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "languageId"
        case name
    }
}
