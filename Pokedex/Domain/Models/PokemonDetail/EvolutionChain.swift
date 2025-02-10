//
//  EvolutionChain.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

struct EvolutionChain: Decodable, Identifiable {
    let id: Int
    let name: String
    let evolvesTo: [EvolutionChain]
    let speciesNames: [LanguageModel]
    
    static let template = EvolutionChain(id: 151, name: "mew", evolvesTo: [], speciesNames: [LanguageModel(id: 9, name: "Mew")])
}
