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
    @Published private var pokemonList = [Species]()
    
    @ObservedObject var languageManager: LanguageManager
    @Published var generation: Int
    @Published var searchText = ""
    
    var filteredPokemon: [Species] {
        var filtered = pokemonList
        if generation > 0 {
            filtered = filtered.filter {
                $0.generationId == generation
            }
        }
        return searchText.isEmpty ? filtered : filtered.filter {
            languageManager.getLanguage(from: $0.names).lowercased().contains(searchText.lowercased())
        }
    }
    
    init(languageManager: LanguageManager) {
        self.generation = UserDefaults.standard.integer(forKey: "generation")
        self.languageManager = languageManager
        self.pokemonManager.getPokemonList { data in
            self.pokemonList = data
        }
    }
}

