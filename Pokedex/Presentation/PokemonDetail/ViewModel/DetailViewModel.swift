//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation
import SwiftUI

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonSpecies: PokemonSpeciesDetail?
    @Published var selectedPokemon: Int = 0
    
    private let fetchPokemonUseCase: FetchPokemonUseCase
    
    init(fetchPokemonUseCase: FetchPokemonUseCase) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
    }
    
    func getPokemon(_ pokemon: Int) async {
        self.reset()
        await self.fetchPokemonData(pokemon)
    }
    
    private func reset() {
        self.pokemonSpecies = nil
        self.selectedPokemon = 0
    }
    
    private func fetchPokemonData(_ pokemon: Int) async {
        do {
            let species = try await self.fetchPokemonUseCase.execute(id: pokemon)
            withAnimation {
                self.pokemonSpecies = species
            }
        } catch {
            print(error)
        }
    }
    
    func playCry(_ pokemon: Int) {
        if let cry = URL(string: "https://pokemoncries.com/cries/\(pokemon).mp3") {
            PlayerManager.shared.play(url: cry)
        }
    }
}
