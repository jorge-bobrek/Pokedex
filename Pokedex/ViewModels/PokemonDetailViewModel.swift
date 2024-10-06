//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation
import SwiftUI

final class PokemonDetailViewModel: ObservableObject {
    private let pokemonManager = PokemonDetailManager()
    private let movesManager = PokemonMovesManager()
    private let evolutionManager = EvolutionManager()
    private let playerManager = PlayerManager()
    
    @Published var pokemonDetails: PokemonDetail?
    @Published var pokemonEvolutionChain: EvolutionChain?
    @Published var pokemonMoves: [PokemonMoveDetail] = []
    @Published var selected: Int = 1
    var games: [Int] = [] {
        didSet {
            if !games.contains(self.selected) {
                self.selected = games.first ?? 1
            }
        }
    }
    
    func getPokemon(_ pokemon: Int) {
        self.reset()
        self.getPokemonData(pokemon)
        self.getMovements(pokemon)
    }
    
    func reset() {
        self.pokemonDetails = nil
        self.pokemonEvolutionChain = nil
        self.pokemonMoves = []
        self.games = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 20, 23, 25]
    }
    
    func getPokemonData(_ pokemon: Int) {
        self.pokemonManager.getPokemon(id: pokemon) { data in
            self.pokemonDetails = data
            if let evo = data?.species.evolutionChainId {
                self.getEvolutionChain(evo)
            }
        }
    }
    
    func getEvolutionChain(_ chain: Int) {
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
