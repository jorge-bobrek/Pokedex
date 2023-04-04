//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var vm = PokemonDetailViewModel()
    @State private var scrollViewID = UUID()
    let pokemon: PokemonPage
    var language: Language = .spanish
    enum ScrollPosition: Hashable {
        case image(index: Int)
    }
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                if vm.pokemonDetails == nil || vm.pokemonSpecies == nil {
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
                        PokemonInformation()
                    }
                    .padding(20)
                } else {
                    LazyVStack(alignment: .center, spacing: 40) {
                        VStack {
                            HStack {
                                DetailText(String(format: "#%04d", vm.pokemonDetails!.id), .Title)
                                Spacer()
                            }
                            .id(0)
                            PokemonImage(id: vm.pokemonDetails!.id, size: 300)
                            DetailText(vm.getSpeciesName(names: vm.pokemonSpecies!.names, language: language), .Title)
                            Text("\(vm.getSpeciesName(names: vm.pokemonSpecies!.names, language: .japanese)) (\(vm.getSpeciesName(names: vm.pokemonSpecies!.names, language: .japanese).applyingTransform(.toLatin, reverse: false)!.capitalized))")
                                .font(.title)
                        }
                        //MARK: Details
                        PokemonInformation()
                            .onAppear {
                                vm.loadData()
                            }
                        
                        //MARK: Evolution
                        DetailText("Evolución", .Title)
                        if vm.pokemonEvolutionChain == nil {
                            ProgressView()
                        } else {
                            PokemonEvolution(proxy: proxy)
                        }
                    }
                }
            }
            .onAppear {
                vm.loadPokemon(pokemon: pokemon)
            }
            .environmentObject(vm)
            .padding(20)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonPage.example)
    }
}

