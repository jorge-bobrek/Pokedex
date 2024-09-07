//
//  ContentView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/03/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(vm.filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon.id)) {
                            PokemonItemView(pokemon: pokemon)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .animation(.easeIn(duration: 0.3), value: vm.filteredPokemon.count)
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $vm.searchText, placement: .toolbar)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
