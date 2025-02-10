//
//  SpeciesRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

class SpeciesRepository: SpeciesRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func getAllSpecies() async throws -> [PokemonSpeciesList] {
        return try await networkService.fetchData(endpoint: "species")
    }
}
