//
//  PokemonEvolution.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct PokemonEvolution: View {
    let chain: EvolutionChain
    let completion: (Int) -> ()
    
    var body: some View {
        if let rootSpecies = chain.pokemonSpecies.first(where: { $0.evolvesFromSpeciesId == nil }), chain.pokemonSpecies.count > 1 {
            ScrollView(.horizontal) {
                HStack {
                    EvolutionLine(species: rootSpecies, groupedSpecies: groupSpeciesByEvolvesFrom(species: chain), completion: completion)
                }
            }
        } else {
            DetailText("Este pokémon no evoluciona", .Info)
        }
    }
    
    struct EvolutionLine: View {
        @EnvironmentObject var languageManager: LanguageManager
        let species: Species
        let groupedSpecies: [Int: [Species]]
        let completion: (Int) -> ()
        var pokemonImageURL: URL { return Bundle.main.getSpriteArtwork(for: species.id)! }
        var body: some View {
            HStack(alignment: .center) {
                HStack {
                    VStack(spacing: 0) {
                        PokemonURLImage(url: pokemonImageURL, size: 100)
                            .onTapGesture {
                                completion(species.id)
                            }
                        DetailText(languageManager.getLanguage(from:species.names), .Typing)
                    }
                    if let evolutions = groupedSpecies[species.id], !evolutions.isEmpty {
                        VStack {
                            ForEach(evolutions, id: \.id) { evolution in
                                HStack {
                                    Image(systemName: "arrow.right")
                                    // Mostrar la cadena evolutiva de la siguiente especie
                                    EvolutionLine(species: evolution, groupedSpecies: groupedSpecies, completion: completion)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Función para agrupar las especies por evolvesFromSpeciesId
    private func groupSpeciesByEvolvesFrom(species: EvolutionChain) -> [Int: [Species]] {
        var speciesDict: [Int: [Species]] = [:]
        
        for specie in species.pokemonSpecies {
            if let evolvesFromId = specie.evolvesFromSpeciesId {
                speciesDict[evolvesFromId, default: []].append(specie)
            }
        }
        return speciesDict
    }
}
