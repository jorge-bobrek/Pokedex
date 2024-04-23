//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation
import SchemaAPI

class PokemonListManager {
    func getPokemonList(completion: @escaping ([Species.Specy]) -> ()) {
        Network.shared.apollo.fetch(query: GetListQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                if let species = graphQLResult.data?.pokemon_v2_pokemonspecies {
                    completion(self.process(data: species))
                } else if let errors = graphQLResult.errors {
                    print(errors)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func process(data: [SpeciesData]) -> [Species.Specy] {
        return Species(data).species
    }
}
