//
//  ViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    private let playerManager = PlayerManager()
    
    @Published var pokemonList = [PokemonPage]()
    @Published var pokemonDetails: PokemonModel?
    @Published var pokemonSpecies: SpeciesModel?
    @Published var pokemonAbilities = ["", "", ""]
    @Published var searchText = ""
    
    var filteredPokemon: [PokemonPage] {
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
    
    func getIndex(url: String) -> Int {
        return Int(url.split(separator: "/").last!)!
    }
    
    func getPokemon(pokemon: PokemonPage) {
        let id = getIndex(url: pokemon.url)
        self.pokemonManager.getPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func getSpecies(pokemon: PokemonPage) {
        let id = getIndex(url: pokemon.url)
        self.pokemonManager.getSpecies(id: id) { data in
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
