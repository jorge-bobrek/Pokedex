//
//  NaturesView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

import SwiftUI

struct NaturesView: View {
    @StateObject var viewModel: PokemonNaturesViewModel
    @EnvironmentObject var languageManager: LanguageManager
    
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.fixed(34), alignment: .center),
        GridItem(.fixed(34), alignment: .center),
        GridItem(.fixed(34), alignment: .center),
        GridItem(.fixed(34), alignment: .center),
        GridItem(.fixed(34), alignment: .center),
        GridItem(.fixed(34), alignment: .center)
    ]
    var body: some View {
        VStack {
            // Encabezado de la tabla
            LazyVGrid(columns: columns, spacing: 10) {
                DetailText("Nature", .Detail)
                    .frame(maxWidth: .infinity, alignment: .center)
                DetailText("HP", .Detail)
                DetailText("Atk", .Detail)
                DetailText("Def", .Detail)
                DetailText("SpA", .Detail)
                DetailText("SpD", .Detail)
                DetailText("Spe", .Detail)
            }
            .padding(.horizontal)

            // Contenido con scroll
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.natureList) { nature in
                        DetailText(languageManager.getLanguage(from: nature.names), .Detail)
                        ForEach(1..<7) { index in
                            if nature.increased == index {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundStyle(.green)
                            } else if nature.decreased == index {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundStyle(.red)
                            } else {
                                Text("-")
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity) // Permitir que el scroll ocupe todo el espacio disponible
        }
    }
}

#Preview {
    NaturesView(viewModel: PokemonNaturesViewModel())
        .environmentObject(LanguageManager(selectedLanguage: .roomaji))
}
