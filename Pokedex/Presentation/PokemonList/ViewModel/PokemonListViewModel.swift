//
//  PokemonPageViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SwiftUI

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published private var pokemonList = [PokemonSpeciesList]()
    @Published var generation: Region {
        didSet { UserDefaults.standard.set(generation.rawValue, forKey: "generation") }
    }
    @Published var searchText = ""
    
    private let speciesRepository = SpeciesRepository()
    private let languageManager = LanguageManager.shared
    
    init() {
        self.generation = Region(rawValue: UserDefaults.standard.integer(forKey:"generation")) ?? .all
        Task { [weak self] in
            guard let self else { return }
            await self.getPokemonList(for: LanguageManager.shared.selectedLanguage)
        }
    }
    
    func getPokemonList(for language: Language) async {
        do {
            self.pokemonList = try await self.speciesRepository.getAllSpecies()
        } catch {
            print(error)
        }
    }
    
    var filteredPokemon: [PokemonSpeciesList] {
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

enum Region: Int, CaseIterable{
    case all = 0
    case kanto = 1
    case johto = 2
    case hoenn = 3
    case sinnoh = 4
    case unova = 5
    case kalos = 6
    case alola = 7
    case galar = 8
    case paldea = 9
}
