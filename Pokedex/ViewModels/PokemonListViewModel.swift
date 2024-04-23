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
    
    @Published var pokemonList = [Species.Specy]()
    @Published var searchText = ""
    
    var filteredPokemon: [Species.Specy] {
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
}
