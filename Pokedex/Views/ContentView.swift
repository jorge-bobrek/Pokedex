//
//  ContentView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/03/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(vm.filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonPageView(pokemon: pokemon)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .animation(.easeIn(duration: 0.3), value: vm.filteredPokemon.count)
                .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $vm.searchText, placement: .toolbar)
        }
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
