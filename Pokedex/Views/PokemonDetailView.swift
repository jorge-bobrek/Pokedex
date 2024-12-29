//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var vm = PokemonDetailViewModel()
    @StateObject var languageManager = LanguageManager.shared
    let pokemon: Int
    
    var body: some View {
        VStack(spacing: 0) {
            if let specy = vm.pokemonSpecies {
                if specy.pokemons.count > 1 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Tabs(tabs: specy.pokemons.map { detail in
                            Tab(icon: "Sprites/\(detail.id)", title: detail.id < 10000 ? specy.speciesName : detail.pokemonForms.first?.formName ?? specy.speciesName)
                        }, selectedTab: $vm.selectedPokemon)
                    }
                }
                let selected = specy.pokemons[vm.selectedPokemon]
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .center, spacing: 40) {
                            // MARK: Information
                            PokemonInformation(species: specy, details: selected)
                                .id("top")
                                .navigationTitle("#\(String(format: "%04d", specy.id)) - \(specy.speciesName)")
                            
                            // MARK: Stats
                            PokemonStats(stats: selected.pokemonStats)
                            
                            // MARK: Moves
                            DetailText("Movimientos", .Title)
                            VersionsSection(selected: $vm.selectedGame, games: vm.games)
                            PokemonMoves(selected: $vm.selectedGame, moves: selected.pokemonMoves)
                            
                            // MARK: Evolution
                            DetailText("Evolución", .Title)
                            if let chain = vm.pokemonEvolutionChain {
                                PokemonEvolution(chain: chain) { index in
                                    withAnimation {
                                        vm.getPokemon(index, in: LanguageManager.shared.selectedLanguage)
                                        vm.playCry(index)
                                        proxy.scrollTo("top", anchor: .top)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .onChange(of: languageManager.selectedLanguage) { newLanguage in
                        vm.onLanguageChange(newLanguage)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            } else {
                DetailSkeletonView()
                MovementsSkeletonView()
            }
        }
        .onAppear {
            vm.getPokemon(pokemon, in: languageManager.selectedLanguage)
        }
    }
}

struct DetailSkeletonView: View {
    let columns = [
        GridItem(.fixed(150), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    var body: some View {
        VStack {
            HStack {
                SkeletonView(cellFrame: (90, 40), cornerRadius: 5)
                Spacer()
            }
            SkeletonView(cellFrame: (300, 300), cornerRadius: 20)
                .padding(.bottom, 10)
            SkeletonView(cellFrame: (120, 40), cornerRadius: 5)
                .padding(.bottom, 30)
            LazyVGrid(columns: columns, spacing: 10) {
                DetailText("Tipos", .Info)
                SkeletonView(cellFrame: (100, 30), cornerRadius: 5)
                DetailText("Habilidad", .Info)
                SkeletonView(cellFrame: (120, 28), cornerRadius: 5)
                DetailText("Hab. Oculta", .Info)
                SkeletonView(cellFrame: (90, 28), cornerRadius: 5)
                // DetailText("Rat. Captura", .Info)
                // SkeletonView(cellFrame: (50, 28), cornerRadius: 5)
                DetailText("Rat. Género", .Info)
                SkeletonView(cellFrame: (130, 28), cornerRadius: 5)
                // DetailText("Ciclos ecl.", .Info)
                // SkeletonView(cellFrame: (30, 28), cornerRadius: 5)
                DetailText("Color", .Info)
                SkeletonView(cellFrame: (60, 28), cornerRadius: 5)
            }
        }
    }
}

struct MovementsSkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("").frame(maxWidth: .infinity, alignment: .leading)
                DetailText("Level", .Table)
                DetailText("Power", .Table)
                DetailText("Accuracy", .Table)
                DetailText("PP", .Table)
                DetailText("Type", .Table)
                DetailText("Category", .Table)
            }
            ForEach(1..<10) { _ in
                HStack(spacing: 10) {
                    SkeletonView(cellFrame: (100, 20), cornerRadius: 5)
                    SkeletonView(cellFrame: (28, 20), cornerRadius: 5)
                    SkeletonView(cellFrame: (28, 20), cornerRadius: 5)
                    SkeletonView(cellFrame: (44, 20), cornerRadius: 5)
                    SkeletonView(cellFrame: (18, 20), cornerRadius: 5)
                    SkeletonView(cellFrame: (22, 20), cornerRadius: 5)
                    SkeletonView(cellFrame: (44, 20), cornerRadius: 5)
                }
            }
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: 133)
    }
}

struct DetailSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSkeletonView()
    }
}

struct MovementsSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        MovementsSkeletonView()
    }
}

