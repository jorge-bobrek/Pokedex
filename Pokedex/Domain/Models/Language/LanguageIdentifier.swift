//
//  LanguageIdentifier.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

struct LanguageIdentifier: Decodable, Identifiable {
    let id: Int
    let name: [LanguageModel]
}
