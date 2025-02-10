//
//  AnySpeciesRepository.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

protocol SpeciesRepositoryProtocol {
    func getAllSpecies() async throws -> [PokemonSpeciesList]
}
