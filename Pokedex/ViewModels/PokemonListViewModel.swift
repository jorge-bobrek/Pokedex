//
//  PokemonPageViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SwiftUI

final class PokemonListViewModel: ObservableObject {
    @Published private var pokemonList = [Species]()
    @Published var generation: Int
    @Published var searchText = ""
    
    private let speciesRepository = SpeciesRepository()
    private let languageManager = LanguageManager.shared
    
    init() {
        self.generation = UserDefaults.standard.integer(forKey: "generation")
        self.getPokemonList(for: LanguageManager.shared.selectedLanguage)
    }
    
    func getPokemonList(for language: Language) {
        self.pokemonList = self.speciesRepository.getAllSpecies(language)
    }
    
    var filteredPokemon: [Species] {
        var filtered = pokemonList
        if generation > 0 {
            filtered = filtered.filter {
                $0.generationId == generation
            }
        }
        return searchText.isEmpty ? filtered : filtered.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}

