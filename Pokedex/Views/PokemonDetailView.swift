//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var vm: PokemonDetailViewModel = PokemonDetailViewModel()
    var language: Language = .spanish
    let pokemon: Int
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                if let details = vm.pokemonDetails {
                    LazyVStack(alignment: .center, spacing: 40) {
                        VStack {
                            HStack {
                                DetailText(String(format: "#%04d", details.id), .Title)
                                Spacer()
                            }
                            .id(0)
                            PokemonImage(url: Bundle.main.getSpriteArtwork(for: details.id, canBeShiny: true), size: 300)
                            DetailText(Bundle.main.getLanguage(names: details.specy.names, language: language), .Title)
                            Text(Bundle.main.getLanguage(names: details.specy.names, language: .jaHrkt))
                                .font(.title)
                            Text(Bundle.main.getLanguage(names: details.specy.names, language: .roomaji).capitalized)
                        }
                        //MARK: Details
                        PokemonInformation(details: details)
                        
                    
                        //MARK: Evolution
                        DetailText("Evolución", .Title)
                        if let chain = vm.pokemonEvolutionChain {
                            PokemonEvolution(chain: chain) { index in
                                withAnimation {
                                    vm.getPokemon(index)
                                    proxy.scrollTo(0, anchor: .bottom)
                                }
                            }
                        } else {
                            ProgressView()
                        }
                        //MARK: Moves
                        DetailText("Movimientos", .Title)
                        if let moves = vm.pokemonMovements {
                            PokemonMoves(moves: moves)
                        } else {
                            ProgressView()
                        }
                     
                    }
                } else {
                    VStack {
                        HStack {
                            Text("*****")
                                .font(.largeTitle)
                                .redacted(reason: .placeholder)
                            Spacer()
                        }
                        ProgressView()
                            .frame(width: 300, height: 300)
                        Text("*********")
                            .font(.largeTitle)
                            .redacted(reason: .placeholder)
                        HStack {
                            Text("********")
                                .font(.title)
                                .redacted(reason: .placeholder)
                            Text("********")
                                .font(.title)
                                .redacted(reason: .placeholder)
                        }
                        //PokemonInformation(details: details)
                    }
                    .padding(20)
                }
            }
            .padding(20)
        }
        .onAppear {
            vm.getPokemon(pokemon)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: 133)
    }
}

