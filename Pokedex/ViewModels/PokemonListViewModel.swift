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
    @Published var generation: Region
    @Published var searchText = ""
    
    private let speciesRepository = SpeciesRepository()
    private let languageManager = LanguageManager.shared
    
    init() {
        self.generation = Region(rawValue: UserDefaults.standard.integer(forKey:"generation")) ?? .all
        self.getPokemonList(for: LanguageManager.shared.selectedLanguage)
    }
    
    func getPokemonList(for language: Language) {
        self.pokemonList = self.speciesRepository.getAllSpecies(language)
        UserDefaults.standard.set(language.rawValue, forKey: "language")
    }
    
    var filteredPokemon: [Species] {
        var filtered = pokemonList
        if generation != .all {
            filtered = filtered.filter {
                $0.generationId == generation.rawValue
            }
        }
        return searchText.isEmpty ? filtered : filtered.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}

