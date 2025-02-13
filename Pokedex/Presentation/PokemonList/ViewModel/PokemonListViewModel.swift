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
    @Published var searchText = ""
    @Published var generation: Region? {
        didSet { UserDefaults.standard.set(generation?.rawValue, forKey: "generation") }
    }
    
    private let speciesRepository: SpeciesRepositoryProtocol
    
    init(speciesRepository: SpeciesRepositoryProtocol = SpeciesRepository()) {
        self.speciesRepository = speciesRepository
        self.generation = Region(rawValue: UserDefaults.standard.integer(forKey:"generation"))
    }
    
    func getPokemonList() async {
        do {
            let list = try await self.speciesRepository.getAllSpecies()
            self.pokemonList = list
        } catch {
            print(error)
        }
    }
    
    var filteredPokemon: [PokemonSpeciesList] {
        var filtered = pokemonList
        if let generation {
            filtered = filtered.filter {
                $0.generationId == generation.rawValue
            }
        }
        return searchText.isEmpty ? filtered : filtered.filter {
            // TODO: Get list from "names" instead of "name"
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}

enum Region: Int, CaseIterable {
    case kanto = 1
    case johto = 2
    case hoenn = 3
    case sinnoh = 4
    case unova = 5
    case kalos = 6
    case alola = 7
    case galar = 8
    case paldea = 9
    
    var displayName: String {
        switch self {
        case .kanto: return "kanto"
        case .johto: return "johto"
        case .hoenn: return "hoenn"
        case .sinnoh: return "sinnoh"
        case .unova: return "unova"
        case .kalos: return "kalos"
        case .alola: return "alola"
        case .galar: return "galar"
        case .paldea: return "paldea"
        }
    }
}
