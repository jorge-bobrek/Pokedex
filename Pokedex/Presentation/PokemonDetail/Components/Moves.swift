//
//  PokemonMoves.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/04/23.
//

import SwiftUI

struct PokemonMoves: View {
    @State var selectedGame: Int
    let moves: [PokemonMove]
    let games: [Int]
    
    init(moves: [PokemonMove]) {
        self.moves = moves
        self.games = Array(Set(moves.map { $0.versionGroupId })).sorted()
        self.selectedGame = games.first ?? 1
    }
    
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.fixed(28), alignment: .center),
        GridItem(.fixed(28), alignment: .center),
        GridItem(.fixed(50), alignment: .center),
        GridItem(.fixed(18), alignment: .center),
        GridItem(.fixed(22), alignment: .center),
        GridItem(.fixed(50), alignment: .center)
    ]
    var body: some View {
        if !moves.isEmpty {
            VStack {
                Text("Moves")
                    .detailedText(size: .Title)
                VersionsSection(selected: $selectedGame, games: games)
                LazyVGrid(columns: columns, spacing: 10) {
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
                    
                    ForEach(moves.filter { $0.versionGroupId == selectedGame && $0.level > 0 }, id: \.self) { move in
                        LanguageText(of: move.name)
                            .detailedText(size: .Typing)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        InfoText("\(move.level)")
                            .detailedText(size: .Typing)
                        if let power = move.power {
                            InfoText("\(power)")
                                .detailedText(size: .Typing)
                        } else {
                            InfoText("--")
                                .detailedText(size: .Typing)
                        }
                        if let accuracy = move.accuracy {
                            InfoText("\(accuracy)%")
                                .detailedText(size: .Typing)
                        } else {
                            InfoText("--")
                                .detailedText(size: .Typing)
                        }
                        InfoText("\(move.pp)")
                            .detailedText(size: .Typing)
                        Image(MonType[move.typeId]!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                        DamageType(damageId: move.moveDamageClassId)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                    }
                }
            }
            .onChange(of: games) { newGames in
                if !newGames.contains(selectedGame) {
                    selectedGame = newGames.first ?? 1
                }
            }
        }
    }
}

struct DamageType: View {
    let damageId: Int
    var body: some View {
        switch damageId {
        case 1:
            Image("status")
                .resizable()
        case 2:
            Image("physical")
                .resizable()
        case 3:
            Image("special")
                .resizable()
        default:
            EmptyView()
        }
    }
}

struct VersionsSection: View {
    @Binding var selected: Int
    let games: [Int]
    let versions: [(String, [Color])] = [
        ("RB",[Color("red"), Color("blue")]), // 1
        ("Y",[Color("yellow"), Color("yellow")]), // 2
        ("GS",[Color("gold"), Color("silver")]), // 3
        ("C",[Color("crystal"), Color("crystal")]), // 4
        ("RS",[Color("ruby"), Color("sapphire")]), // 5
        ("E",[Color("emerald"), Color("emerald")]), // 6
        ("FRLF",[Color("firered"), Color("leafgreen")]), // 7
        ("DP",[Color("diamond"), Color("pearl")]), // 8
        ("P",[Color("platinum"), Color("platinum")]), // 9
        ("HGSS",[Color("heartgold"), Color("soulsilver")]), // 10
        ("BW",[Color("black"), Color("white")]), // 11
        ("B2W2",[Color("black"), Color("white")]), // 14
        ("XY",[Color("x"), Color("y")]), // 15
        ("ORAS",[Color("omegaruby"), Color("alphasapphire")]), // 16
        ("SM",[Color("sun"), Color("moon")]), // 17
        ("USUM",[Color("ultrasun"), Color("ultramoon")]), // 18
        ("SWSH",[Color("sword"), Color("shield")]), // 20
        ("BDSP",[Color("brilliantdiamond"), Color("shiningpearl")]), // 23
        ("LA",[Color("black"), Color("gold")]), // 24
        ("SV",[Color("scarlet"), Color("violet")]), // 25
    ]
    let versionIndices: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 20, 23, 24, 25]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(Array(versions.enumerated()), id: \.1.0) { index, version in
                    let actualIndex = versionIndices[index] // Obtener el índice real comentado
                    if games.contains(actualIndex) {
                        Button {
                            selected = actualIndex // Asignar el índice real al seleccionado
                        } label: {
                            Text(version.0)
                                .detailedText(size: .Info)
                                .stroke(color: .black.opacity(actualIndex == selected ? 1 : 0.3))
                                .frame(width: 64, height: 32)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            version.1[0].opacity(actualIndex == selected ? 1 : 0.3),
                                            version.1[1].opacity(actualIndex == selected ? 1 : 0.3)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(8)
                                .foregroundStyle(.white)
                        }
                        .pixelRoundedBorder(cornerRadius: 8, pixelSize: 2)
                    }
                }
            }
            .padding(4)
        }
    }
}
