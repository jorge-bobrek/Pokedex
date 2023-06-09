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
    @Published var pokemonEvolutionChain: EvolutionChainModel?
    
    func loadPokemon(pokemon: PokemonPage) {
        let id = Bundle.main.getIndex(url: pokemon.url)
        self.getPokemon(pokemon: id)
        self.getSpecies(pokemon: id)
        self.playCry(pokemon: pokemon)
    }
    
    func loadData() {
        for ability in self.pokemonDetails!.abilities {
            self.getAbilityName(index: Bundle.main.getIndex(url: ability.ability.url), position: ability.slot - 1, language: .spanish)
        }
        self.getEvolutionChain(pokemon: Bundle.main.getIndex(url: self.pokemonSpecies!.evolutionChain.url))
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
    
    func getEvolutionChain(pokemon: Int) {
        self.pokemonManager.getEvolutionChain(id: pokemon) { data in
            DispatchQueue.main.async {
                self.pokemonEvolutionChain = data
            }
        }
    }
    
    func getSpeciesName(names: [Name], language: Language) -> String {
        for element in names {
            if element.language.name == language.rawValue {
                return element.name
            }
        }
        return ""
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
