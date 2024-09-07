//
//  PokemonMoves.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/04/23.
//

import SwiftUI

struct PokemonMoves: View {
    let moves: [String: [Move]]
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(Array(moves.keys), id: \.self) { name in
                    Text(name)
                        .font(.headline)
                        .frame(height: 30)
                }
            }
            .padding(.top, 40)
            VStack {
                ScrollView(.horizontal) {
                    VersionsSection()
                        .padding(.bottom, 2)
                    ForEach(Array(moves.keys), id: \.self) { name in
                        NamesSection(name: name, moves: moves[name]!)
                    }
                }
            }
        }
        
    }
}

struct NamesSection: View {
    let name: String
    let moves: [Move]
    let versions: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 14, 15, 16, 17, 18, 19, 20, 23, 25]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack(spacing: 10) {
                ForEach(versions, id: \.self) { index in
                    MoveView(move: moves.first(where: { $0.version?.id == index }))
                }
            }
        }
    }
}

struct VersionsSection: View {
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
        ("GPGE",[Color("gopikachu"), Color("goeevee")]), // 19
        ("SWSH",[Color("sword"), Color("shield")]), // 20
        ("BDSP",[Color("brilliantdiamond"), Color("shiningpearl")]), // 23
        ("SV",[Color("scarlet"), Color("violet")]), // 25
    ]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(versions, id: \.0) { version in
                Text(version.0) // Mostrar el nombre del string
                    .bold()
                    .frame(width: 52, height: 30)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [version.1[0], version.1[1]]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(2)
                    .foregroundColor(.white)
            }
        }
    }
}

struct MoveView: View {
    let move: Move?
    var body: some View {
        Text(move?.level?.description ?? "")
            .frame(width: 52, height: 30)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(2)
    }
}
