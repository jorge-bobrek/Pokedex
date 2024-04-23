//
//  PokemonEvolution.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct PokemonEvolution: View {
    let proxy: ScrollViewProxy
    @EnvironmentObject var vm: PokemonDetailViewModel
    
    var body: some View {
        if (vm.pokemonEvolutionChain!.chain.evolvesTo!.isEmpty) {
            VStack(spacing: 0) {
                PokemonImage(id: Bundle.main.getIndex(url: vm.pokemonEvolutionChain!.chain.species.url), size: 100)
                DetailText("Este Pokémon no evoluciona.", .Info)
            }
        } else {
            ScrollView(.horizontal) {
                HStack {
                    PokemonImage(id: Bundle.main.getIndex(url: vm.pokemonEvolutionChain!.chain.species.url), size: 100)
                        .onTapGesture {
                            //vm.loadPokemon(pokemon: PokemonPage(name: vm.pokemonEvolutionChain!.chain.species.name, url: vm.pokemonEvolutionChain!.chain.species.url))
                            withAnimation {
                                proxy.scrollTo(0, anchor: .bottom)
                            }
                        }
                    PokemonEvolutionLine(proxy: proxy, pokemon: vm.pokemonEvolutionChain!.chain)
                }
            }
        }
    }
}


fileprivate struct PokemonEvolutionLine: View {
    @EnvironmentObject var vm: PokemonDetailViewModel
    let proxy: ScrollViewProxy
    var pokemon: Chain
    
    var body: some View {
        VStack {
            ForEach(pokemon.evolvesTo!) { species in
                HStack(spacing: 10) {
                    Image(systemName: "arrow.right")
                    PokemonImage(id: Bundle.main.getIndex(url: species.species.url), size: 120)
                        .onTapGesture {
                            //vm.loadPokemon(pokemon: PokemonPage(name: species.species.name, url: species.species.url))
                            withAnimation {
                                proxy.scrollTo(0, anchor: .bottom)
                            }
                        }
                    if (!((species.evolvesTo?.isEmpty) == nil)) {
                        PokemonEvolutionLine(proxy: proxy, pokemon: species)
                    }
                }
            }
        }
    }
}
