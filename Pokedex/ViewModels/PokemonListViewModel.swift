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
    
    @ObservedObject var languageManager: LanguageManager
    @Published var pokemonList = [Species.ListSpecy]()
    @Published var searchText = ""
    
    var filteredPokemon: [Species.ListSpecy] {
        return searchText.isEmpty ? pokemonList : pokemonList.filter {
            languageManager.getLanguage(from: $0.names).lowercased().contains(searchText.lowercased())
        }
    }
    
    init(languageManager: LanguageManager) {
        self.languageManager = languageManager
        DispatchQueue.main.async {
            self.pokemonManager.getPokemonList { data in
                self.pokemonList = data
            }
        }
    }
}
