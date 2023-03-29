//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: PokemonPage
    let dimensions: Double = 300
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    DetailText(String(format: "#%04d", vm.getIndex(url: pokemon.url)), .Title)
                    Spacer()
                }
                PokemonImage(id: vm.getIndex(url: pokemon.url), size: dimensions)
                DetailText(pokemon.name, .Title)
                if vm.pokemonDetails == nil || vm.pokemonSpecies == nil {
                    ProgressView()
                        .frame(width: 30, height: 30)
                } else {
                    Text("\(vm.pokemonSpecies!.names[0].name) (\(vm.pokemonSpecies!.names[0].name.applyingTransform(.toLatin, reverse: false)!.capitalized))")
                            .font(.title)
                    Grid(alignment: .leading, verticalSpacing: 10) {
                        GridRow {
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 0)
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 0)
                        }
                        GridRow {
                            DetailText("Tipos", .Detail)
                            HStack {
                                ForEach (vm.pokemonDetails!.types) { type in
                                    TypeImage(type.type.name)
                                }
                            }
                        }
                        GridRow {
                            DetailText(vm.pokemonAbilities[1].isEmpty ? "Habilidad" : "Habilidades", .Detail)
                            if vm.pokemonAbilities[0].isEmpty {
                                Text("********")
                                    .redacted(reason: .placeholder)
                            } else {
                                VStack(alignment: .leading) {
                                    DetailText(vm.pokemonAbilities[0], .Info)
                                    if !vm.pokemonAbilities[1].isEmpty {
                                        DetailText(vm.pokemonAbilities[1], .Info)
                                    }
                                }
                            }
                        }
                        GridRow {
                            DetailText("Hab. oculta", .Detail)
                            DetailText(vm.pokemonAbilities[2], .Info)
                        }
                        GridRow {
                            DetailText("Peso", .Detail)
                            DetailText(String(format: "%.1f kg", Float(vm.pokemonDetails!.weight)/10), .Info)
                        }
                        GridRow {
                            DetailText("Altura", .Detail)
                            DetailText(String(format: "%.1f m", Float(vm.pokemonDetails!.height)/10), .Info)
                        }
                        GridRow {
                            DetailText("Especie", .Detail)
                            DetailText(vm.getGenusTranslation(array: vm.pokemonSpecies!.genera, language: .spanish), .Info)
                        }
                    }
                    .padding(.top, 20)
                    .onAppear {
                        for ability in vm.pokemonDetails!.abilities {
                            vm.getAbilityName(index: vm.getIndex(url: ability.ability.url), position: ability.slot - 1, language: .spanish)
                        }
                    }
                }
            }
            .padding(20)
        }
        .onAppear {
            vm.getSpecies(pokemon: pokemon)
            vm.getPokemon(pokemon: pokemon)
            vm.playCry(pokemon: pokemon)
        }
        .onDisappear {
            vm.pokemonSpecies = nil
            vm.pokemonDetails = nil
            vm.pokemonAbilities = ["", "", ""]
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: PokemonPage.example)
            .environmentObject(ViewModel())
    }
}

