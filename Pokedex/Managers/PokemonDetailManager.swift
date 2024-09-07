//
//  PokemonDetailManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 30/03/23.
//

import Foundation
import SchemaAPI

class PokemonDetailManager {   
    
    func getPokemon(id: Int, _ completion: @escaping (Pokemon) -> ()) {
        DispatchQueue.main.async {
            Network.shared.apollo.fetch(query: GetDetailQuery(id: GraphQLNullable<Int>(integerLiteral: id))) { result in
                switch result {
                case .success(let graphQLResult):
                    if let pokemon = graphQLResult.data?.pokemon_v2_pokemon.first {
                        completion(self.process(data: pokemon))
                    } else if let errors = graphQLResult.errors {
                        print(errors)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getEvolutionChain(id: Int, _ completion: @escaping (EvolutionChain) -> ()) {
        DispatchQueue.main.async {
            Network.shared.apollo.fetch(query: GetEvolutionChainQuery(id: GraphQLNullable<Int>(integerLiteral: id))) { result in
                switch result {
                case .success(let graphQLResult):
                    if let chain = graphQLResult.data?.pokemon_v2_evolutionchain.first {
                        completion(self.process(data: chain))
                    } else if let errors = graphQLResult.errors {
                        print(errors)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getMovements(id: Int, _ completion: @escaping (Movements) -> ()) {
        DispatchQueue.main.async {
            Network.shared.apollo.fetch(query: GetMovesQuery(id: GraphQLNullable<Int>(integerLiteral: id))) { result in
                switch result {
                case .success(let graphQLResult):
                    if let moves = graphQLResult.data?.pokemon_v2_pokemon.first {
                        completion(self.process(data: moves))
                    } else if let errors = graphQLResult.errors {
                        print(errors)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func process(data: PokemonData) -> Pokemon {
        return Pokemon(data)
    }
    
    private func process(data: EvolutionChainData) -> EvolutionChain {
        return EvolutionChain(data)
    }
    
    private func process(data: MovementsData) -> Movements {
        return Movements(data)
    }
}
