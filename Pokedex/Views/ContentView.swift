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
                VStack {
                    HStack(spacing: 0) {
                        Spacer()
                        DetailText("Generation", .Detail)
                            .padding(.trailing, 2)
                        Picker("Generation", selection: $viewModel.generation) {
                            ForEach(1..<10) { gen in
                                DetailText("\(gen)", .Detail).tag(gen)
                            }
                        }
                        .pickerStyle(.menu)
                        Spacer()
                        NavigationLink(destination: NaturesView(viewModel: PokemonNaturesViewModel())) {
                            HStack {
                                HStack(spacing: 0) {
                                    Image(systemName: "arrow.up.arrow.down")
                                        .foregroundStyle(.green, .red)
                                }
                                DetailText("Natures", .Detail)
                                    .foregroundStyle(.black)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: Text("TO DO")) {
                            HStack {
                                Image(systemName: "duffle.bag.fill")
                                    .foregroundStyle(.orange)
                                DetailText("Items", .Detail)
                                    .foregroundStyle(.black)
                            }
                        }
                        Spacer()
                    }
                    ScrollViewReader { proxy in
                        ScrollView {
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
                            .searchable(text: $viewModel.searchText, placement: .toolbar)
                            .onChange(of: viewModel.filteredPokemon) { newValue in
                                if let firstPokemonId = newValue.first?.id {
                                    withAnimation {
                                        proxy.scrollTo(firstPokemonId, anchor: .top)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // MARK: Bottom View
            HStack {
                Spacer()
                Picker("Language", selection: $languageManager.selectedLanguage) {
                    ForEach(Array(Language.allCases.enumerated()), id: \.element) { id, language in
                        DetailText("\(Flags[id]) \(language)", .Detail).tag(language)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .background(.gray)
        }
    }
}
