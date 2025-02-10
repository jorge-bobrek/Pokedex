//
//  FetchPokemonUseCase.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

class FetchPokemonUseCase {
    private let repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol = PokemonRepository()) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> PokemonSpeciesDetail? {
        try await repository.getPokemon(id: id)
    }
}
