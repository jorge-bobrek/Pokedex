//
//  ContentView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @StateObject var viewModel: PokemonListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.filteredPokemon) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon.id)) {
                                PokemonItemView(pokemon: pokemon)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .animation(.easeIn(duration: 0.3), value: viewModel.filteredPokemon.count)
                    .navigationBarTitleDisplayMode(.inline)
                }
                .searchable(text: $viewModel.searchText, placement: .toolbar)
            }
            HStack {
                ForEach(Array(Language.allCases.enumerated()), id: \.element) { id, language in
                    Button {
                        languageManager.changeLanguage(to: language)
                    } label: {
                        Text(Flags[id])
                            .font(.system(size: 42))
                    }
                }
            }
            .padding(.horizontal, 10)
            .background(.gray)
        }
    }
}
