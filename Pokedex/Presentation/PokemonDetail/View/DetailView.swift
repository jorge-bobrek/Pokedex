//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var vm = PokemonDetailViewModel(fetchPokemonUseCase: .init())
    @StateObject var languageManager = LanguageManager.shared
    let pokemon: Int
    
    var body: some View {
        VStack(spacing: 0) {
            if let specy = vm.pokemonSpecies {
                if specy.pokemons.count > 1 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Tabs(tabs: specy.pokemons.map { detail in
                            HStack {
                                if detail.id < 10000 {
                                    Text(specy.name)
                                        .detailedText(size: .Detail)
                                } else {
                                    LanguageText(of: detail.pokemonForms.first?.names)
                                        .detailedText(size: .Detail)
                                }
                            }
                            .foregroundColor(.primary)
                            .padding()
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
                                .navigationTitle("\(String(format: "#%04d", specy.id)) - \(specy.speciesNames[7].name ?? "")")
                            
                            // MARK: Evolution
                            Text("Evolution")
                                .detailedText(size: .Title)
                            if !specy.evolutionChain.evolvesTo.isEmpty {
                                PokemonEvolution(chain: specy.evolutionChain) { index in
                                    Task {
                                        await vm.getPokemon(index, in: LanguageManager.shared.selectedLanguage)
                                        withAnimation { proxy.scrollTo("top", anchor: .top) }
                                        vm.playCry(index)
                                    }
                                }
                            } else {
                                Text("This species does not evolve")
                                    .detailedText(size: .Detail)
                            }
                            
                            // MARK: Stats
                            Text("Stats")
                                .detailedText(size: .Title)
                            PokemonStats(stats: selected.pokemonStats)
                            
                            // MARK: Moves
                            if !selected.pokemonMoves.isEmpty {
                                Text("Moves")
                                    .detailedText(size: .Title)
                                VersionsSection(selected: $vm.selectedGame, games: vm.games)
                                PokemonMoves(selected: $vm.selectedGame, moves: selected.pokemonMoves)
                            }
                            
                            Spacer(minLength: 10)
                        }
                        .padding(.horizontal)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            } else {
                DetailSkeletonView()
                MovementsSkeletonView()
            }
        }
        .task {
            await vm.getPokemon(pokemon, in: languageManager.selectedLanguage)
            vm.playCry(pokemon)
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
                Text("Types")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (100, 30), cornerRadius: 5)
                Text("Ability")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (120, 28), cornerRadius: 5)
                Text("Hid. Ability")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (90, 28), cornerRadius: 5)
                // Text("Rat. Captura")
                // SkeletonView(cellFrame: (50, 28), cornerRadius: 5)
                Text("Gender ratio")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (130, 28), cornerRadius: 5)
                // Text("Ciclos ecl.")
                // SkeletonView(cellFrame: (30, 28), cornerRadius: 5)
                Text("Color")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (60, 28), cornerRadius: 5)
            }
        }
    }
}

struct MovementsSkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Color.clear.frame(maxWidth: .infinity, alignment: .leading)
                Text("Level")
                    .detailedText(size: .Table)
                Text("Power")
                    .detailedText(size: .Table)
                Text("Accuracy")
                    .detailedText(size: .Table)
                Text("PP")
                    .detailedText(size: .Table)
                Text("Type")
                    .detailedText(size: .Table)
                Text("Category")
                    .detailedText(size: .Table)
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

