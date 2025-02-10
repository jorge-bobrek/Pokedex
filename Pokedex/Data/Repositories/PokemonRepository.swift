//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

class PokemonRepository: PokemonRepositoryProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func getPokemon(id: Int) async throws -> PokemonSpeciesDetail? {
        return try await networkService.fetchData(endpoint: "pokemon/\(id)")
    }
}

