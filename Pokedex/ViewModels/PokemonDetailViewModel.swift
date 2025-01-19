//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation
import SwiftUI

final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonSpecies: PokemonSpecies?
    @Published var pokemonEvolutionChain: [SpeciesChain]?
    @Published var selectedPokemon: Int = 0 {
        didSet { self.getMovementsGames() }
    }
    @Published var selectedGame: Int = 1
    
    private let pokemonRepository = PokemonRepository()
    private let evolutionRepository = EvolutionRepository()
    private let playerManager = PlayerManager()
    
    var games: [Int] = [] {
        didSet {
            if !games.contains(self.selectedGame) {
                self.selectedGame = games.first ?? 1
            }
        }
    }
    
    func onLanguageChange(_ language: Language) {
        if let currentPokemon = self.pokemonSpecies?.id {
            self.getPokemon(currentPokemon, in: language)
        }
        UserDefaults.standard.set(language.rawValue, forKey: "language")
    }
    
    func getPokemon(_ pokemon: Int, in language: Language) {
        withAnimation {
            self.reset()
            self.getPokemonData(pokemon, language)
            self.selectedPokemon = 0
        }
    }
    
    private func reset() {
        self.pokemonSpecies = nil
        self.pokemonEvolutionChain = nil
        self.games = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 20, 23, 24, 25]
    }
    
    private func getPokemonData(_ pokemon: Int,_ language: Language) {
        self.pokemonSpecies = self.pokemonRepository.getPokemon(id: pokemon, language: language)
        if let species = pokemonSpecies {
            self.getEvolutionChain(species.evolutionChainId)
        }
    }
    
    private func getEvolutionChain(_ chain: Int) {
        self.pokemonEvolutionChain = self.evolutionRepository.getEvolutionChain(forChainId: chain)
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
