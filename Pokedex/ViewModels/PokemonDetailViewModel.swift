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
    
    func getPokemon(_ pokemon: Int) {
        self.getPokemonData(pokemon)
        self.getMovements(pokemon)
    }
    
    func getPokemonData(_ pokemon: Int) {
        self.pokemonDetails = nil
        self.pokemonManager.getPokemon(id: pokemon) { data in
            self.pokemonDetails = data
            if let evo = data?.species.evolutionChainId {
                self.getEvolutionChain(evo)
            }
//                if let cry = data.cries.first {
//                    self.playCry(url: cry.cries)
//                }
        }
        
    }
    
    func getEvolutionChain(_ chain: Int) {
        self.pokemonEvolutionChain = nil
        self.evolutionManager.getEvolutionChain(for: chain) { data in
            self.pokemonEvolutionChain = data
        }
    }
    func getMovements(_ pokemon: Int) {
        self.pokemonMoves = []
        self.movesManager.loadPokemonMoves(forPokemonId: pokemon) { data in
            self.pokemonMoves = data
        }
    }
    
    private func playCry(url: String) {
        self.playerManager.play(url: URL(string: url)!)
    }
}
