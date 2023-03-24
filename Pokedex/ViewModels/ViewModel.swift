//
//  ViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [PokemonPage]()
    @Published var pokemonDetails: Pokemon?
    @Published var searchText = ""
    
    var filteredPokemon: [PokemonPage] {
        return searchText.isEmpty ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        self.pokemonManager.getPokemonList { data in
            DispatchQueue.main.async {
                self.pokemonList = data
            }
        }
    }
    
    func getPokemonIndex(pokemon: PokemonPage) -> Int {
        return Int(pokemon.url.split(separator: "/").last!)!
    }
    
    func getPokemon(pokemon: PokemonPage) {
        let id = getPokemonIndex(pokemon: pokemon)
        self.pokemonManager.getPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
}
