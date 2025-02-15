//
//  PokemonStats.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 6/10/24.
//

import SwiftUI

struct PokemonStats: View {
    let stats: [PokemonStat]

    var body: some View {
        VStack {
            Text("Stats")
                .detailedText(size: .Title)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(stats) { stat in
                    if let statName = Stat[stat.id] {
                        HStack {
                            Text(statName)
                                .detailedText(size: .Typing)
                            Text(String(format: "%3d", stat.stat))
                                .detailedText(size: .Typing)
                            StatColor(stat: stat.stat)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct StatColor: View {
    let stat: Int
    var body: some View {
        Color.clear
            .frame(width: CGFloat(stat), height: 16)
            .pixelRoundedBorder(cornerRadius: 8, pixelSize: 2, borderColor: getColor(stat), fillColor: getColor(stat).opacity(0.8))
    }
    
    func getColor(_ stat: Int) -> Color {
        switch stat {
        case 0...40:
            return Color("stat 1")
        case 41...60:
            return Color("stat 2")
        case 61...80:
            return Color("stat 3")
        case 81...100:
            return Color("stat 4")
        case 101...120:
            return Color("stat 5")
        default:
            return Color("stat 6")
        }
    }
}

#Preview {
    PokemonStats(stats: PokemonDetail.mew.pokemonStats)
}
