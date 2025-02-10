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
    @Published var selectedPokemon: Int = 0 {
        didSet { self.getMovementsGames() }
    }
    @Published var selectedGame: Int = 1
    
    private let playerManager = PlayerManager()
    
    private let fetchPokemonUseCase: FetchPokemonUseCase
    
    init(fetchPokemonUseCase: FetchPokemonUseCase) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
    }
    
    var games: [Int] = [] {
        didSet {
            if !games.contains(self.selectedGame) {
                self.selectedGame = games.first ?? 1
            }
        }
    }
    
    func getPokemon(_ pokemon: Int, in language: Language) async {
        self.reset()
        await self.fetchPokemonData(pokemon, language)
        self.selectedPokemon = 0
    }
    
    private func reset() {
        self.pokemonSpecies = nil
        self.games = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 20, 23, 24, 25]
    }
    
    private func fetchPokemonData(_ pokemon: Int,_ language: Language) async {
        do {
            let species = try await self.fetchPokemonUseCase.execute(id: pokemon)
            self.pokemonSpecies = species
        } catch {
            print(error)
        }
    }
    
    func getMovementsGames() {
        if let moves = self.pokemonSpecies?.pokemons[selectedPokemon].pokemonMoves {
            self.games = Array(Set(moves.map { $0.versionGroupId })).sorted()
        }
    }
    
    func playCry(_ pokemon: Int) {
        if let cry = URL(string: "https://pokemoncries.com/cries/\(pokemon).mp3") {
            self.playerManager.play(url: cry)
        }
    }
}
