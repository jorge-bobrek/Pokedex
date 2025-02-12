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
        VStack {
            Text("Evolution")
                .detailedText(size: .Title)
            if !chain.evolvesTo.isEmpty {
                PokemonEvolutionChain(chain: chain, completion: completion)
            } else {
                Text("This species does not evolve")
                    .detailedText(size: .Detail)
            }
        }
    }
}

private struct PokemonEvolutionChain: View {
    let chain: EvolutionChain
    let completion: (Int) -> ()
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                PokemonImage(name: chain.name, size: 100, endpoint: .pokemon)
                LanguageText(of: chain.speciesNames)
                    .detailedText(size: .Hint)
            }
            .onTapGesture {
                completion(chain.id)
            }
            if !chain.evolvesTo.isEmpty {
                Image(systemName: "arrow.right")
            }
            VStack {
                ForEach(chain.evolvesTo) { chain in
                    PokemonEvolutionChain(chain: chain, completion: completion)
                }
            }
        }
    }
}
