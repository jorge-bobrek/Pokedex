//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation
import SwiftUI

final class PokemonDetailViewModel: ObservableObject {
    private let pokemonManager = PokemonDetailManager()
    private let playerManager = PlayerManager()
    
    @Published var pokemonDetails: PokemonModel?
    @Published var pokemonSpecies: SpeciesModel?
    @Published var pokemonAbilities = ["", "", ""]
    
    init() {
    }
    
    func getPokemon(pokemon: Int) {
        self.pokemonManager.getPokemon(id: pokemon) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func getSpecies(pokemon: Int) {
        self.pokemonManager.getSpecies(id: pokemon) { data in
            DispatchQueue.main.async {
                self.pokemonSpecies = data
            }
        }
    }
    
    func getAbilityName(index: Int, position: Int, language: Language) {
        self.pokemonManager.getAbility(id: index) { data in
            DispatchQueue.main.async {
                for element in data.names {
                    if element.language.name == language.rawValue {
                        self.pokemonAbilities[position] = element.name
                    }
                }
            }
        }
    }
    
    func getGenusTranslation(array: [Genus], language: Language) -> String {
        for element in array {
            if element.language.name == language.rawValue {
                return element.genus
            }
        }
        return ""
    }
    
    func playCry(pokemon: PokemonPage) {
        self.playerManager.play(url: URL(string: "https://play.pokemonshowdown.com/audio/cries/\(pokemon.name.replacingOccurrences(of: "-", with: "")).mp3")!)
    }
}
