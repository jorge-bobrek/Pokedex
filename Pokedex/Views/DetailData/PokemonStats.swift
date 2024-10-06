//
//  PokemonStats.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 6/10/24.
//

import SwiftUI

struct PokemonStats: View {
    let stats: [PokemonStat]
    let columns = [
        GridItem(.fixed(40), alignment: .center),
        GridItem(.fixed(28), alignment: .center),
        GridItem(.flexible(), alignment: .leading)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(stats) { stat in
                if let statName = Stat[stat.id] {
                    DetailText(statName, .Typing)
                    DetailText(String(stat.stat), .Typing)
                    StatColor(stat: stat.stat)
                }
            }
        }
    }
}

struct StatColor: View {
    let stat: Int
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(getColor(stat).opacity(0.8))
            .frame(width: CGFloat(stat), height: 16)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(getColor(stat), lineWidth: 2)
            )
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
    PokemonStats(stats: PokemonDetail.template.stats)
}
