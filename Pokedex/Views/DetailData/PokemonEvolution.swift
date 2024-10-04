//
//  PokemonEvolution.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct PokemonEvolution: View {
    let chain: EvolutionChain
    let completion: (Int) -> ()
    
    var body: some View {
        if let rootSpecies = chain.pokemonSpecies.first(where: { $0.evolvesFromSpeciesId == nil }) {
            ScrollView(.horizontal) {
                HStack {
                    EvolutionLine(species: rootSpecies, groupedSpecies: groupSpeciesByEvolvesFrom(species: chain), completion: completion)
                }
            }
        }
    }
    
    struct EvolutionLine: View {
        @EnvironmentObject var languageManager: LanguageManager
        let species: Species
        let groupedSpecies: [Int: [Species]]
        let completion: (Int) -> ()
        var body: some View {
            HStack(alignment: .center) {
                HStack {
                    if let evolutions = species.evolutions {
                        VStack(spacing: 0) {
                            ForEach(evolutions, id: \.id) { evolution in
                                ZStack {
                                    ArrowShape()
                                        .fill(Color.secondary.opacity(0.4))
                                        .frame(width: 32, height: 92)
                                        .rotationEffect(.degrees(90))
                                        .aspectRatio(1, contentMode: .fit)
                                    Text("\(evolution.trigger.name)")
                                }
                                .frame(width: 120, height: 30)
                                .onTapGesture {
                                    withAnimation(.snappy(duration: 0.2)) {
                                        languageManager.evolution = evolution
                                    }
                                }
                            }
                        }
                    }
                    VStack(spacing: 0) {
                        PokemonImage(url: Bundle.main.getSpriteArtwork(for: species.id), size: 100)
                            .onTapGesture {
                                completion(species.id)
                            }
                        DetailText(languageManager.getLanguage(from:species.names), .Typing)
                    }
                    if let evolutions = groupedSpecies[species.id], !evolutions.isEmpty {
                        VStack {
                            ForEach(evolutions, id: \.id) { evolution in
                                // Mostrar la cadena evolutiva de la siguiente especie
                                EvolutionLine(species: evolution, groupedSpecies: groupedSpecies, completion: completion)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Función para agrupar las especies por evolvesFromSpeciesId
    private func groupSpeciesByEvolvesFrom(species: EvolutionChain) -> [Int: [Species]] {
        var speciesDict: [Int: [Species]] = [:]
        
        for specie in species.pokemonSpecies {
            if let evolvesFromId = specie.evolvesFromSpeciesId {
                speciesDict[evolvesFromId, default: []].append(specie)
            }
        }
        return speciesDict
    }
}

struct EvolutionRequeriments: View {
    @EnvironmentObject var languageManager: LanguageManager
    let evolution: Evolution
    var body: some View {
        VStack {
            ZStack {
                ArrowShape()
                    .fill(Color.secondary.opacity(0.4))
                    .frame(width: 32, height: 92)
                    .rotationEffect(.degrees(90))
                    .aspectRatio(1, contentMode: .fit)
                Text("\(evolution.trigger.name)")
            }
            .frame(height: 30)
            if let minLevel = evolution.minLevel { Text("Nivel: \(minLevel)") }
            if let minAffection = evolution.minAffection { Text("Afecto: \(minAffection)") }
            if let minHappiness = evolution.minHappiness { Text("Felicidad: \(minHappiness)") }
            if let minBeauty = evolution.minBeauty { Text("Belleza: \(minBeauty)") }
            if evolution.needsOverworldRain { Text("Lluvia") }
            if let timeOfDay = TimeOfDay(rawValue: evolution.timeOfDay)?.toLanguageModels() { Text("Hora: \(languageManager.getLanguage(from: timeOfDay))") }
            if let relativePhysicalStats = evolution.relativePhysicalStats { Text("stats: \(relativePhysicalStats)") }
            if let heldItem = evolution.heldItem?.names { Text("Usando: \(languageManager.getLanguage(from: heldItem))") }
            if let location = evolution.location?.names { Text("Ubicación: \(languageManager.getLanguage(from: location))") }
            if let knownMove = evolution.knownMove { Text("Conociendo movimiento: \(knownMove)") }
            if let knownMoveType = evolution.knownMoveType?.typeNames { Text("Conociendo movimiento tipo: \(languageManager.getLanguage(from: knownMoveType))") }
            if let tradeSpecies = evolution.tradeSpecies { Text("tradeSpecies: \(tradeSpecies)") }
            if let partySpecies = evolution.partySpecies { Text("partySpecies: \(partySpecies)") }
            if let partyType = evolution.partyType { Text("partyType: \(partyType)") }
            if evolution.turnUpsideDown { Text("turnUpsideDown") }
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .shadow(color: .gray, radius: 1)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.2))
    }
}
