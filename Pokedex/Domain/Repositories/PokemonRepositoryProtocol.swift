//
//  AnyPokemonRepository.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 8/02/25.
//

protocol PokemonRepositoryProtocol {
    func getPokemon(id: Int) async throws -> PokemonSpeciesDetail?
}
