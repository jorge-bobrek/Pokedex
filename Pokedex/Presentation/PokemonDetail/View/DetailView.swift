//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @StateObject private var vm = PokemonDetailViewModel(fetchPokemonUseCase: .init())
    let pokemon: Int
    
    var body: some View {
        VStack(spacing: 0) {
            if let specy = vm.pokemonSpecies {
                if specy.pokemons.count > 1 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Tabs(tabs: specy.pokemons.map { detail in
                            HStack {
                                if detail.id < 10000 {
                                    LanguageText(of: specy.speciesNames)
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
                            PokemonEvolution(chain: specy.evolutionChain) { index in
                                Task {
                                    await vm.getPokemon(index)
                                    withAnimation { proxy.scrollTo("top", anchor: .top) }
                                    vm.playCry(index)
                                }
                            } 
                            
                            // MARK: Stats
                            PokemonStats(stats: selected.pokemonStats)
                            
                            // MARK: Moves
                            PokemonMoves(moves: selected.pokemonMoves)
                            
                            Spacer(minLength: 10)
                        }
                        .padding(.horizontal)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            } else {
                ScrollView {
                    VStack(alignment: .center, spacing: 40) {
                        InformationSkeletonView()
                        EvolutionSkeletonView()
                        StatsSkeletonView()
                        MovementsSkeletonView()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .task {
            await vm.getPokemon(pokemon)
            vm.playCry(pokemon)
        }
    }
}

struct InformationSkeletonView: View {
    let columns = [
        GridItem(.fixed(150), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    var body: some View {
        VStack {
            SkeletonView(cellFrame: (90, 30), cornerRadius: 5)
            SkeletonView(cellFrame: (300, 300), cornerRadius: 20)
                .padding(.bottom, 10)
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
                Text("Gender ratio")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (130, 28), cornerRadius: 5)
                Text("Color")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (60, 28), cornerRadius: 5)
                Text("Egg Group")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (70, 28), cornerRadius: 5)
                Text("Height")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (30, 28), cornerRadius: 5)
                Text("Weight")
                    .detailedText(size: .Info)
                SkeletonView(cellFrame: (40, 28), cornerRadius: 5)
            }
        }
    }
}

struct EvolutionSkeletonView: View {
    var body: some View {
        VStack {
            Text("Evolution")
                .detailedText(size: .Title)
            HStack {
                VStack {
                    SkeletonView(cellFrame: (100, 100), cornerRadius: 5)
                    SkeletonView(cellFrame: (60, 16), cornerRadius: 5)
                }
                Image(systemName: "arrow.right")
                VStack {
                    SkeletonView(cellFrame: (100, 100), cornerRadius: 5)
                    SkeletonView(cellFrame: (60, 16), cornerRadius: 5)
                }
            }
        }
    }
}

struct StatsSkeletonView: View {
    let columns = [
        GridItem(.fixed(30), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    var body: some View {
        VStack {
            Text("Stats")
                .detailedText(size: .Title)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(Array(Stat), id: \.key) { key, value in
                    HStack {
                        Text(value)
                            .detailedText(size: .Info)
                        SkeletonView(cellFrame: (30, 28), cornerRadius: 5)
                        Spacer()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct MovementsSkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 13) {
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
                    Spacer()
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
        InformationSkeletonView()
    }
}

struct MovementsSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        MovementsSkeletonView()
    }
}

