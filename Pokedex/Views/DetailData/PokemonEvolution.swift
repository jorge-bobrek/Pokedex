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
                EvolutionLine(species: rootSpecies, groupedSpecies: groupSpeciesByEvolvesFrom(species: chain), completion: completion)
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
                    if let evolutions = species.evolutions, !evolutions.isEmpty {
                        VStack {
                            Image(systemName: "arrow.right")
                            ForEach(evolutions, id: \.id) { evolution in
                                EvolutionRequeriments(evolution: evolution)
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
    
    struct EvolutionRequeriments: View {
        @EnvironmentObject var languageManager: LanguageManager
        let evolution: Evolution
        var body: some View {
            VStack {
                Text("\(evolution.trigger.name)")
                if let minLevel = evolution.minLevel { Text("Nivel: \(minLevel)") }
                if let minAffection = evolution.minAffection { Text("Afecto: \(minAffection)") }
                if let minHappiness = evolution.minHappiness { Text("Felicidad: \(minHappiness)") }
                if let minBeauty = evolution.minBeauty { Text("Belleza: \(minBeauty)") }
                if evolution.needsOverworldRain { Text("Lluvia") }
                if let timeOfDay = TimeOfDay(rawValue: evolution.timeOfDay)?.toLanguageModels() { Text("Hora: \(languageManager.getLanguage(from: timeOfDay))") }
                if let relativePhysicalStats = evolution.relativePhysicalStats { Text("stats: \(relativePhysicalStats)") }
                if let heldItem = evolution.heldItem?.names { Text("heldItem: \(languageManager.getLanguage(from: heldItem))") }
                if let location = evolution.location?.names { Text("location: \(languageManager.getLanguage(from: location))") }
                if let knownMove = evolution.knownMove { Text("knownMove: \(knownMove)") }
                if let knownMoveType = evolution.knownMoveType?.typeNames { Text("knownMoveType: \(languageManager.getLanguage(from: knownMoveType))") }
                if let tradeSpecies = evolution.tradeSpecies { Text("tradeSpecies: \(tradeSpecies)") }
                if let partySpecies = evolution.partySpecies { Text("partySpecies: \(partySpecies)") }
                if let partyType = evolution.partyType { Text("partyType: \(partyType)") }
                if evolution.turnUpsideDown { Text("turnUpsideDown") }
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
