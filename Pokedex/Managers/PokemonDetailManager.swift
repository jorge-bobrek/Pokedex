//
//  PokemonDetailManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation

class PokemonDetailManager {    
    func getPokemon(id: Int, _ completion: @escaping (PokemonModel) -> ()) {
        getModel(id: id, model: PokemonModel.self, url: "pokemon") { data in
            completion(data)
        }
    }
    
    func getSpecies(id: Int, _ completion: @escaping (SpeciesModel) -> ()) {
        getModel(id: id, model: SpeciesModel.self, url: "pokemon-species") { data in
            completion(data)
        }
    }
    
    func getAbility(id: Int, _ completion: @escaping (AbilityModel) -> ()) {
        getModel(id: id, model: AbilityModel.self, url: "ability") { data in
            completion(data)
        }
    }
    
    func getEvolutionChain(id: Int, _ completion: @escaping (EvolutionChainModel) -> ()) {
        getModel(id: id, model: EvolutionChainModel.self, url: "evolution-chain") { data in
            completion(data)
        }
    }
    
    private func getModel<T: Decodable>(id: Int, model: T.Type, url: String, _ completion: @escaping (T) -> ()){
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/\(url)/\(id)", model: model.self, completion: { data in
            completion(data)
        }) { error in
            print(error)
        }
    }
}
