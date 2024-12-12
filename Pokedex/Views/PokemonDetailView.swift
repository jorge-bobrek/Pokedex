//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var vm: PokemonDetailViewModel = PokemonDetailViewModel()
    @EnvironmentObject var languageManager: LanguageManager
    let pokemon: Int
    
    var body: some View {
        ZStack {
            ScrollViewReader { proxy in
                ScrollView {
                    if let details = vm.pokemonDetails {
                        VStack(alignment: .center, spacing: 40) {
                            //MARK: Information
                            VStack {
                                HStack {
                                    DetailText(String(format: "#%04d", details.id), .Title)
                                    Spacer()
                                }
                                .id("top")
                                PokemonImage(url: Bundle.main.getSpriteArtwork(for: details.id, canBeShiny: true), size: 300) { vm.playCry(details.id) }
                                DetailText(languageManager.getLanguage(from: details.species.speciesNames), .Title)
                            }
                            PokemonInformation(details: details)
                            
                            //MARK: Moves
                            VStack {
                                DetailText("Movimientos", .Title)
                                VersionsSection(selected: $vm.selected, games: vm.games)
                                if !vm.pokemonMoves.isEmpty {
                                    PokemonMoves(selected: $vm.selected, moves: vm.pokemonMoves)
                                } else {
                                    MovementsSkeletonView()
                                }
                            }
                            
                            //MARK: Evolution
                            DetailText("Evolución", .Title)
                            if let chain = vm.pokemonEvolutionChain {
                                PokemonEvolution(chain: chain) { index in
                                    withAnimation {
                                        vm.getPokemon(index)
                                        proxy.scrollTo("top", anchor: .top)
                                    }
                                }
                            } else {
                                Text(String(details.species.evolutionChainId ?? -1))
                            }
                            
                            //MARK: Stats
                            VStack {
                                DetailText("Características", .Title)
                                PokemonStats(stats: details.stats)
                            }
                        }
                    } else {
                        DetailSkeletonView()
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .onAppear {
            vm.getPokemon(pokemon)
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
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.fixed(28), alignment: .center),
        GridItem(.fixed(28), alignment: .center),
        GridItem(.fixed(44), alignment: .center),
        GridItem(.fixed(18), alignment: .center),
        GridItem(.fixed(22), alignment: .center),
        GridItem(.fixed(44), alignment: .center)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            // Encabezado de la tabla
            Text("").frame(maxWidth: .infinity, alignment: .leading)
            DetailText("Level", .Table)
            DetailText("Power", .Table)
            DetailText("Accuracy", .Table)
            DetailText("PP", .Table)
            DetailText("Type", .Table)
            DetailText("Category", .Table)
            
            ForEach(1..<10) { _ in
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

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: 133)
            .environmentObject(LanguageManager())
    }
}

struct DetailSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSkeletonView()
    }
}

