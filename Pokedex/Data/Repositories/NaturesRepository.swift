//
//  PokemonNaturesManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

class NaturesRepository: NaturesRepositoryProtocol {
    
    private let jsonManager: AnyJSONManager
    
    init(jsonManager: AnyJSONManager = JSONManager.shared) {
        self.jsonManager = jsonManager
    }
    
    func fetchNatures() async throws -> [Nature] {
        try await jsonManager.load(fileName: "Natures", as: NaturesModel.self).natures
    }
}
