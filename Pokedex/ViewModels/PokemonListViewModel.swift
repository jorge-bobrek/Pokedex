//
//  PokemonPageViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SwiftUI

final class PokemonListViewModel: ObservableObject {
    private let pokemonManager = PokemonListManager()
    
    @Published var pokemonList = [Species.ListSpecy]()
    @Published var searchText = ""
    
    var filteredPokemon: [Species.ListSpecy] {
        return searchText.isEmpty ? pokemonList : pokemonList.filter {
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        DispatchQueue.main.async {
            self.pokemonManager.getPokemonList { data in
                self.pokemonList = data
            }
        }
    }
}
