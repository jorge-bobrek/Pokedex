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
                    HStack {
                        Spacer()
                        Picker("Gen", selection: $viewModel.generation) {
                            ForEach(0..<10) { gen in
                                DetailText("\(gen)", .Detail).tag(gen)
                            }
                        }
                        DetailText("Gen", .Detail)
                            .foregroundStyle(.primary)
                        .pickerStyle(.menu)
                        Spacer()
                        NavigationLink(destination: NaturesView(viewModel: PokemonNaturesViewModel())) {
                            HStack {
                                HStack(spacing: 0) {
                                    Image(systemName: "arrow.up.arrow.down")
                                        .foregroundStyle(.green, .red)
                                }
                                DetailText("Natures", .Detail)
                                    .foregroundStyle(.primary)
                            }
                        }
                        Spacer()
                        NavigationLink(destination: ItemListView()) {
                            HStack {
                                Image(systemName: "gym.bag.fill")
                                    .foregroundStyle(.orange)
                                DetailText("Items", .Detail)
                                    .foregroundStyle(.primary)
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
                                UserDefaults.standard.set(viewModel.generation, forKey: "generation")
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
                DropDownLanguage()
                if !languageManager.isLatin {
                    Toggle(isOn: $languageManager.latinToggle) {
                        DetailText("To latin", .Typing)
                    }
                    .frame(width: 128)
                }
                Spacer()
            }
            .padding(.top, 10)
            .background(.tertiary)
        }
    }
    
    struct DropDownLanguage: View {
        @EnvironmentObject var languageManager: LanguageManager
        
        var body: some  View {
            VStack(spacing: 0) {
                if languageManager.showDropdown {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Language.allCases, id: \.self) { language in
                            Button {
                                withAnimation(.snappy(duration: 0.15)) {
                                    languageManager.selectedLanguage = language
                                    languageManager.showDropdown.toggle()
                                    UserDefaults.standard.set(language.rawValue, forKey: "language")
                                }
                            } label: {
                                DetailText("\(Flags[language.rawValue - 1]) \(language)", .Detail)
                                    .padding(.top, 4)
                            }
                        }
                    }
                }
                // selected item
                Button {
                    withAnimation(.snappy(duration: 0.15)) {
                        languageManager.showDropdown.toggle()
                    }
                } label: {
                    DetailText("\(Flags[languageManager.selectedLanguage.rawValue - 1]) \(languageManager.selectedLanguage)", .Detail)
                        .frame(width: 140)
                        .padding(.vertical, 4)
                }
            }
            .foregroundStyle(.primary)
            .borderBackground(cornerRadius: 4)
            .frame(height: 36, alignment: .bottom)
            .onTapBackground(enabled: languageManager.showDropdown) {
                withAnimation(.snappy(duration: 0.15)) {
                    languageManager.showDropdown.toggle()
                }
            }
        }
    }
}

