//
//  PokemonMoves.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/04/23.
//

import SwiftUI

struct PokemonMoves: View {
    @EnvironmentObject var vm: PokemonDetailViewModel
    private let columns = [GridItem](repeating: GridItem(.fixed(30)), count: VersionGroupEnum.allCases.count)
    
    var body: some View {
        if let moves = vm.sortedMoves {
            ScrollView(.horizontal) {
                VStack {
                    HStack {
                        Spacer(minLength: 100)
                        ForEach(VersionGroupEnum.allCases.indices, id: \.self) { id in
                            Text(String(id))
                                .bold()
                                .frame(width: 30)
                        }
                    }
                    ForEach(moves.level) { move in
                        HStack {
                            Text(move.move.name)
                                .frame(width: 100)
                                .onAppear(perform: {
                                    print("~🟡\(move.move.url)")
                                })
                            LazyVGrid(columns: columns) {
                                ForEach(VersionGroupEnum.allCases, id: \.rawValue) { version in
                                    if let level = move.versionGroupDetails.first(where: { $0.versionGroup.name?.rawValue ?? "" == version.rawValue }) {
                                        Text(level.levelLearnedAt.description)
                                    } else {
                                        Text("-")
                                    }
                                }
                            }
                        }
                        Divider()
                    }
                }
            }
        } else {
            ProgressView()
        }
    }
}
