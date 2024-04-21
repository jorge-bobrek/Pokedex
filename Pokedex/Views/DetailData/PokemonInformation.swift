//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct PokemonInformation: View {
    @EnvironmentObject var vm: PokemonDetailViewModel
    
    var body: some View {
        if let details = vm.pokemonDetails {
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
                        ForEach (details.types) { type in
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
                if !vm.pokemonAbilities[2].isEmpty {
                    GridRow {
                        DetailText("Hab. oculta", .Detail)
                        DetailText(vm.pokemonAbilities[2], .Info)
                    }
                }
                GridRow {
                    DetailText("Peso", .Detail)
                    DetailText(String(format: "%.1f kg", Float(details.weight)/10), .Info)
                }
                GridRow {
                    DetailText("Altura", .Detail)
                    DetailText(String(format: "%.1f m", Float(details.height)/10), .Info)
                }
                GridRow {
                    DetailText("Especie", .Detail)
                    DetailText(vm.getGenusTranslation(array: vm.pokemonSpecies?.genera ?? [], language: .spanish), .Info)
                }
            }
        } else {
            Text("*********")
                .font(.largeTitle)
                .redacted(reason: .placeholder)
                .padding(.top, 20)
            HStack(spacing: 40) {
                VStack {
                    ForEach(1..<7) { _ in
                        Text("********")
                            .font(.title)
                            .redacted(reason: .placeholder)
                    }
                }
                VStack {
                    ForEach(1..<7) { _ in
                        Text("********")
                            .font(.title)
                            .redacted(reason: .placeholder)
                    }
                }
            }
        }
    }
}
