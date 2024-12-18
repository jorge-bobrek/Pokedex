//
//  PokemonPageViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SwiftUI
import Combine

final class PokemonListViewModel: ObservableObject {
    @Published private var pokemonList = [Species]()
    @Published var generation: Int
    @Published var searchText = ""
    
    private let speciesRepository = SpeciesRepository()
    private let languageManager = LanguageManager.shared
    private var languageCancellable: AnyCancellable?
    
    init() {
        self.generation = UserDefaults.standard.integer(forKey: "generation")
        languageCancellable = languageManager.$selectedLanguage
            .sink { [weak self] newLanguage in
                guard let self = self else { return }
                self.getPokemonList(for: newLanguage)
            }
        self.getPokemonList(for: languageManager.selectedLanguage)
    }
    
    private func getPokemonList(for language: Language) {
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
            $0.name.contains(searchText.lowercased())
        }
    }
}

