//
//  PokemonEvolution.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct PokemonEvolution: View {
    let chain: [SpeciesChain]
    let completion: (Int) -> ()
    
    var body: some View {
        if let rootSpecies = chain.first(where: { $0.evolvesFromSpeciesId == 0 }), chain.count > 1 {
            EvolutionLine(species: rootSpecies, chain: chain, completion: completion)
        } else {
            DetailText("Este pokémon no evoluciona", .Detail)
        }
    }
    
    struct EvolutionLine: View {
        let species: SpeciesChain
        let chain: [SpeciesChain]
        let completion: (Int) -> ()
        
        var body: some View {
            HStack {
                VStack(spacing: 0) {
                    PokemonImage(name: species.name, size: 100)
//                    DetailText("\(species.id)", .Typing)
                }
                .onTapGesture {
                    completion(species.id)
                }
                let evolutions = chain.filter({ $0.evolvesFromSpeciesId == species.id })
                if !evolutions.isEmpty {
                    VStack {
                        ForEach(evolutions, id: \.id) { evolution in
                            HStack {
                                Image(systemName: "arrow.right")
                                // Mostrar la cadena evolutiva de la siguiente especie
                                EvolutionLine(species: evolution, chain: chain, completion: completion)
                            }
                        }
                    }
                }
            }
        }
    }
}
