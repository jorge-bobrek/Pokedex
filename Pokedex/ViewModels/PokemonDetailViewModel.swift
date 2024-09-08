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
    private let playerManager = PlayerManager()
    
    @Published var pokemonDetails: Pokemon?
    @Published var pokemonEvolutionChain: EvolutionChain?
    @Published var pokemonMovements: Movements?
    
    func getPokemon(_ pokemon: Int) {
        self.getPokemonData(pokemon)
        self.getMovements(pokemon)
    }
    
    func getPokemonData(_ pokemon: Int) {
        DispatchQueue.main.async {
            self.pokemonDetails = nil
            self.pokemonManager.getPokemon(id: pokemon) { data in
                self.pokemonDetails = data
                if let evo = data.specy.evolutionChain {
                    self.getEvolutionChain(evo)
                }
                if let cry = data.cry {
                    self.playCry(url: cry)
                }
            }
        }
    }
    
    func getEvolutionChain(_ chain: Int) {
        DispatchQueue.main.async {
            self.pokemonManager.getEvolutionChain(id: chain) { data in
                self.pokemonEvolutionChain = data
            }
        }
    }
    func getMovements(_ pokemon: Int) {
        DispatchQueue.main.async {
            self.pokemonMovements = nil
            self.pokemonManager.getMovements(id: pokemon) { data in
                self.pokemonMovements = data
            }
        }
    }
    
    private func playCry(url: String) {
        self.playerManager.play(url: URL(string: url)!)
    }
}
