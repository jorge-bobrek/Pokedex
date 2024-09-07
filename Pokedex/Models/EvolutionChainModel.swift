//
//  EvolutionChainModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 24/04/24.
//

import Foundation
import SchemaAPI

typealias EvolutionChainData = GetEvolutionChainQuery.Data.Pokemon_v2_evolutionchain

struct EvolutionChain: Decodable {
    let species: [EvolutionSpecy]
    
    init(_ evolutionChain: EvolutionChainData) {
        self.species = evolutionChain.pokemon_v2_pokemonspecies.map({ specy -> EvolutionSpecy in
            EvolutionSpecy(specy)
        })
    }
    
    init(species: [EvolutionSpecy]) {
        self.species = species
    }
    
    struct EvolutionSpecy: Decodable, Identifiable {
        let id: Int
        let names: [LanguageModel]?
        let evolution: EvolutionInfo?
        
        init(_ specy: EvolutionChainData.Pokemon_v2_pokemonspecy) {
            self.id = specy.id
            self.names = specy.pokemon_v2_pokemonspeciesnames.map({ name in
                LanguageModel(id: name.language_id, name: name.name)
            })
            self.evolution = EvolutionInfo(specy.pokemon_v2_pokemonevolutions.first)
        }
        
        struct EvolutionInfo: Decodable {
            let trigger: String?
            let minAffection: Int?
            let minBeauty: Int?
            let minHappiness: Int?
            let minLevel: Int?
            let needsOverworldRain: Bool?
            let partySpeciesId: Int?
            let partyTypeId: Int?
            let relativePhysicalStats: Int?
            let timeOfDay: String?
            let tradeSpeciesId: Int?
            let turnUpsideDown: Bool?
            let gender: String?
            let item: String?
            let location: String?
            let move: String?
            let type: String?
            let heldItemId: String?
            
            init(_ evolution: EvolutionChainData.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonevolution?) {
                self.trigger = evolution?.pokemon_v2_evolutiontrigger?.name
                self.minAffection = evolution?.min_affection
                self.minBeauty = evolution?.min_beauty
                self.minHappiness = evolution?.min_happiness
                self.minLevel = evolution?.min_level
                self.needsOverworldRain = evolution?.needs_overworld_rain
                self.partySpeciesId = evolution?.party_species_id
                self.partyTypeId = evolution?.party_type_id
                self.relativePhysicalStats = evolution?.relative_physical_stats
                self.timeOfDay = evolution?.time_of_day
                self.tradeSpeciesId = evolution?.trade_species_id
                self.turnUpsideDown = evolution?.turn_upside_down
                self.gender = evolution?.pokemon_v2_gender?.name
                self.item = evolution?.pokemon_v2_item?.name
                self.location = evolution?.pokemon_v2_location?.name
                self.move = evolution?.pokemon_v2_move?.name
                self.type = evolution?.pokemon_v2_type?.name
                self.heldItemId = evolution?.pokemonV2ItemByHeldItemId?.name
            }
            
        }
    }
}
