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
                        NavigationLink(destination: Text("TO DO")) {
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
                DropdownLanguage()
                if !languageManager.isLatin() {
                    Toggle(isOn: $languageManager.latinToggle) {
                        DetailText("To latin", .Typing)
                    }
                    .frame(width: 128)
                }
                Spacer()
            }
            .animation(.bouncy(duration: 0.3, extraBounce: 0.2), value: languageManager.isLatin())
            .padding(.top, 10)
            .background(.tertiary)
        }
    }
    
    struct DropdownLanguage: View {
        @EnvironmentObject var languageManager: LanguageManager
        
        var body: some View {
            DetailText("\(languageManager.selectedLanguage)", .Detail)
                .frame(width: 120)
                .padding(4)
                .borderBackground(cornerRadius: 20)
                .onTapGesture {
                    withAnimation(.snappy(duration: 0.2)) {
                        languageManager.showDropdown.toggle()
                    }
                }
                .overlay(alignment: .bottom) {
                    VStack {
                        if languageManager.showDropdown {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(Array(Language.allCases.enumerated()), id: \.element) { id, language in
                                    Button {
                                        withAnimation(.snappy(duration: 0.2)) {
                                            languageManager.selectedLanguage = language
                                            languageManager.showDropdown.toggle()
                                            UserDefaults.standard.set(language.rawValue, forKey: "language")
                                        }
                                    } label: {
                                        DetailText("\(Flags[id]) \(language)", .Detail).tag(language)
                                    }
                                }
                            }
                            .padding(10)
                            .borderBackground(cornerRadius: 4)
                        }
                        Spacer(minLength: 36)
                    }
                    .frame(width: 160)
                }
        }
    }
}
