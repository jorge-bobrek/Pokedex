//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation
import SwiftUI

final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetails: PokemonDetail?
    @Published var pokemonEvolutionChain: [SpeciesChain]?
    @Published var pokemonMoves: [PokemonMove] = []
    @Published var selected: Int = 1
    
    private let pokemonRepository = PokemonRepository()
    private let movesRepository = MovesRepository()
    private let evolutionRepository = EvolutionRepository()
    private let playerManager = PlayerManager()
    
    var games: [Int] = [] {
        didSet {
            if !games.contains(self.selected) {
                self.selected = games.first ?? 1
            }
        }
    }
    
    func onLanguageChange(_ language: Language) {
        if let currentPokemon = self.pokemonDetails?.id {
            self.getPokemon(currentPokemon, in: language)
        }
    }
    
    func getPokemon(_ pokemon: Int, in language: Language) {
        withAnimation {
            self.reset()
            self.getPokemonData(pokemon, language)
            self.getMovements(pokemon, language)
        }
    }
    
    private func reset() {
        self.pokemonDetails = nil
        self.pokemonEvolutionChain = nil
        self.pokemonMoves = []
        self.games = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 20, 23, 25]
    }
    
    private func getPokemonData(_ pokemon: Int,_ language: Language) {
        self.pokemonDetails = self.pokemonRepository.getPokemon(id: pokemon, language: language)
        self.getEvolutionChain(pokemonDetails!.species.evolutionChainId!)
    }
    
    private func getEvolutionChain(_ chain: Int) {
        self.pokemonEvolutionChain = self.evolutionRepository.getEvolutionChain(forChainId: chain)
    }
    
    func getMovements(_ pokemon: Int,_ language: Language) {
        self.pokemonMoves = movesRepository.getAllMoves(forPokemonId: pokemon, language)
        self.games = Array(Set(self.pokemonMoves.map { $0.versionGroupId })).sorted()
    }
    
    func playCry(_ pokemon: Int) {
        if let cry = URL(string: "https://pokemoncries.com/cries/\(pokemon).mp3") {
            self.playerManager.play(url: cry)
        }
    }
}
