//
//  LanguageModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/04/24.
//

import Foundation

struct LanguageModel: Identifiable, Decodable, Hashable {
    let id: Int?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "language_id"
        case name
    }
}
