//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation
import SwiftUI
import Combine

final class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetails: PokemonDetail?
    @Published var pokemonEvolutionChain: EvolutionChain?
    @Published var pokemonMoves: [PokemonMoveDetail] = []
    @Published var selected: Int = 1
    
    private let pokemonRepository = PokemonRepository()
    private let movesManager = PokemonMovesManager()
    private let evolutionManager = EvolutionManager()
    private let playerManager = PlayerManager()
    private let languageManager = LanguageManager.shared
    private var languageCancellable: AnyCancellable?
    
    var games: [Int] = [] {
        didSet {
            if !games.contains(self.selected) {
                self.selected = games.first ?? 1
            }
        }
    }
    
    init() {
        languageCancellable = languageManager.$selectedLanguage
            .sink { [weak self] newLanguage in
                guard let self = self else { return }
                self.onLanguageChange(newLanguage)
            }
    }
    
    private func onLanguageChange(_ language: Language) {
        if let currentPokemon = self.pokemonDetails?.id {
            self.getPokemon(currentPokemon, in: language)
        }
    }
    
    func getPokemon(_ pokemon: Int, in language: Language) {
        withAnimation {
            self.reset()
            self.getPokemonData(pokemon, language)
            self.getMovements(pokemon)
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
    }
    
    private func getEvolutionChain(_ chain: Int) {
        self.evolutionManager.getEvolutionChain(for: chain) { data in
            self.pokemonEvolutionChain = data
        }
    }
    
    func getMovements(_ pokemon: Int) {
        self.movesManager.loadPokemonMoves(forPokemonId: pokemon) { data in
            self.pokemonMoves = data
            self.games = Array(Set(data.map { $0.move.versionGroupId })).sorted()
        }
    }
    
    func playCry(_ pokemon: Int) {
        if let cry = URL(string: "https://pokemoncries.com/cries/\(pokemon).mp3") {
            self.playerManager.play(url: cry)
        }
    }
}
