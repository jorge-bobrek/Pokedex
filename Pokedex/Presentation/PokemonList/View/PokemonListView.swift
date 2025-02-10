//
//  ContentView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/03/23.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel: PokemonListViewModel
    @StateObject var languageManager = LanguageManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                VStack {
                    TopView(region: $viewModel.generation)
                        .zIndex(1)
                    SearchBar(searchText: $viewModel.searchText)
                        .padding(.horizontal)
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
                            .onChange(of: viewModel.filteredPokemon) { newValue in
                                if let firstPokemonId = newValue.first?.id {
                                    withAnimation {
                                        proxy.scrollTo(firstPokemonId, anchor: .top)
                                    }
                                }
                            }
                        }
                    }
                    .onChange(of: languageManager.selectedLanguage) { newLanguage in
                        Task { await viewModel.getPokemonList(for: newLanguage) }
                    }
                }
            }
            BottomView()
        }
        .ignoresSafeArea(.keyboard)
    }
    
    // MARK: Top View
    struct TopView: View {
        @Binding var region: Region
        
        var body: some View {
            HStack {
                Spacer()
                PickerView(selected: $region, items: Region.allCases, direction: .down) { region in
                    Text(String(describing: region))
                        .detailedText(size: .Detail)
                        .frame(width: 100)
                }
                Spacer()
                NavigationLink(destination: NaturesView(viewModel: PokemonNaturesViewModel(fetchNaturesUseCase: .init()))) {
                    HStack {
                        HStack(spacing: 0) {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: .green, location: 0.0),
                                            .init(color: .green, location: 0.5),
                                            .init(color: .red, location: 0.5),
                                            .init(color: .red, location: 1.0)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        }
                        Text("Natures")
                            .detailedText(size: .Detail)
                            .foregroundStyle(.primary)
                    }
                }
                Spacer()
                NavigationLink(destination: ItemListView()) {
                    HStack {
                        Image(systemName: "bag.fill")
                            .foregroundStyle(.orange)
                        Text("Items")
                            .detailedText(size: .Detail)
                            .foregroundStyle(.primary)
                    }
                }
                Spacer()
            }
        }
    }
    
    // MARK: Bottom View
    struct BottomView: View {
        @StateObject var languageManager = LanguageManager.shared
        
        var body: some View {
            HStack {
                Spacer()
                let flags: [String] = ["🇯🇵", "?", "🇰🇷", "🇨🇳", "🇫🇷", "🇩🇪", "🇪🇸", "🇮🇹", "🇺🇸", "?", "?", "?"]
                PickerView(selected: $languageManager.selectedLanguage, items: Language.allCases, direction: .up) { language in
                    Text("\(flags[language.rawValue - 1]) \(language)")
                        .detailedText(size: .Detail)
                        .frame(width: 140)
                }
                if !languageManager.isLatin {
                    Toggle(isOn: $languageManager.latinToggle) {
                        Text("To latin")
                            .detailedText(size: .Typing)
                    }
                    .frame(width: 128)
                }
                Spacer()
            }
            .padding(.top, 10)
            .background(.tertiary)
        }
    }
    
    struct SearchBar: View {
        @Binding var searchText: String
        @FocusState var isFocused: Bool
        
        var body: some View {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.primary)
                    TextField("Search Pokémon", text: $searchText)
                        .detailedText(size: .Detail)
                        .focused($isFocused)
                        .autocorrectionDisabled()
                    if !searchText.isEmpty {
                        Button {
                            searchText.removeAll()
                        } label: {
                            Image(systemName: "x.circle.fill")
                        }
                        .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .borderBackground(cornerRadius: 18)
                if isFocused {
                    Button {
                        isFocused.toggle()
                    } label: {
                        Text("Cancel")
                            .detailedText(size: .Typing)
                    }
                }
            }
            .padding(.vertical, 1)
            .animation(.bouncy(duration: 0.3, extraBounce: 0.2), value: isFocused)
        }
    }
    
}

