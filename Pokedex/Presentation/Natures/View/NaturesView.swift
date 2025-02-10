//
//  NaturesView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

import SwiftUI

struct NaturesView: View {
    @StateObject var viewModel: PokemonNaturesViewModel
    
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
            LazyVGrid(columns: columns, spacing: 10) {
                Text("Nature")
                    .detailedText(size: .Detail)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("HP")
                    .detailedText(size: .Detail)
                Text("Atk")
                    .detailedText(size: .Detail)
                Text("Def")
                    .detailedText(size: .Detail)
                Text("SpA")
                    .detailedText(size: .Detail)
                Text("SpD")
                    .detailedText(size: .Detail)
                Text("Spe")
                    .detailedText(size: .Detail)
            }
            .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.natureList) { nature in
                        LanguageText(of: nature.names)
                            .detailedText(size: .Detail)
                        ForEach(1..<7) { index in
                            if nature.increased == index {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .foregroundStyle(.green)
                            } else if nature.decreased == index {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .foregroundStyle(.red)
                            } else {
                                Image(systemName: "minus")
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
            .task {
                await viewModel.getNatures()
            }
        }
    }
}

#Preview {
    NaturesView(viewModel: PokemonNaturesViewModel(fetchNaturesUseCase: .init()))
}
