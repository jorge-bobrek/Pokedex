//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: PokemonPage
    let dimensions: Double = 300
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                pokemonImage(id: vm.getPokemonIndex(pokemon: pokemon), size: dimensions)
                Text(pokemon.name.uppercased())
                    .lineLimit(1)
                    .font(.custom("My Font", size: 30))
                if vm.pokemonDetails == nil {
                    
                } else {
                    HStack(spacing: 10) {
                        ForEach (vm.pokemonDetails!.types) { type in
                            TypeImage(type.type.name)
                        }
                    }
                }
            }
        }
        .onAppear {
            vm.getPokemon(pokemon: pokemon)
            vm.playCry(pokemon: pokemon)
        }
        .onDisappear {
            vm.pokemonDetails = nil
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonPage.example)
            .environmentObject(ViewModel())
    }
}

