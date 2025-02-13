//
//  ContentView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/03/23.
//

import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @StateObject var viewModel: PokemonListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                PickerView(selected: $viewModel.generation, items: [nil] + Region.allCases, direction: .down) { region in
                    Text(region?.displayName ?? "Todas")
                        .detailedText(size: .Detail)
                        .frame(width: 100)
                }
                Spacer(minLength: 10)
                SearchBar(searchText: $viewModel.searchText)
            }
            .padding(10)
            .zIndex(1)
            Divider()
            ScrollViewReader { proxy in
                ScrollView {
                    if !viewModel.filteredPokemon.isEmpty {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(viewModel.filteredPokemon) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemon: pokemon.id)) {
                                    PokemonItemView(pokemon: pokemon)
                                        .id(pokemon.id)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .animation(.easeIn(duration: 0.3), value: viewModel.filteredPokemon.count)
                        .navigationBarTitleDisplayMode(.inline)
                        .onChange(of: viewModel.filteredPokemon) { newValue in
                            if let firstPokemonId = newValue.first?.id {
                                withAnimation {
                                    proxy.scrollTo(firstPokemonId, anchor: .top)
                                }
                            }
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(0..<7) {_ in
                                HStack(spacing: 10) {
                                    SkeletonView(cellFrame:(CGFloat(87.5), CGFloat(87.5)), cornerRadius: CGFloat(12.5))
                                        .frame(width: 100, height: 100)
                                    SkeletonView(cellFrame:(CGFloat.random(in: 120..<150), 32), cornerRadius: 5)
                                    Spacer(minLength: 0)
                                    SkeletonView(cellFrame:(70, 32), cornerRadius: 5)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
            .background(.background)
        }
        .task {
            await viewModel.getPokemonList()
        }
    }
    
}

