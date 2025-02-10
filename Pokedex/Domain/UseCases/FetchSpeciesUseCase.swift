//
//  FetchSpeciesUseCase.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

class FetchSpeciesUseCase {
    private let repository: SpeciesRepositoryProtocol
    
    init(repository: SpeciesRepositoryProtocol = SpeciesRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [PokemonSpeciesList] {
        try await repository.getAllSpecies()
    }
}
