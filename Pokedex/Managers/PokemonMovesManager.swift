//
//  PokemonMovesManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 10/09/24.
//

import Foundation

final class PokemonMovesManager {
    // Propiedades para almacenar los datos en memoria
    private var pokemonMovesCache: [Pokemon] = []
    private var moveDetailsCache: [MoveDetail] = []
    private var dataLoaded = false
    
    // Función para cargar los movimientos del Pokémon desde la caché
    func loadPokemonMoves(forPokemonId pokemonId: Int, completion: @escaping ([PokemonMoveDetail]) -> Void) {
        // Verificar si ya hemos cargado los datos
        if !dataLoaded {
            // Si no están cargados, los cargamos y almacenamos en caché
            loadAllData { [weak self] success in
                guard let self = self else { return }
                if success {
                    let combinedMoves = self.filterAndCombineMoves(forPokemonId: pokemonId)
                    completion(combinedMoves)
                } else {
                    completion([])
                }
            }
        } else {
            // Si ya están en caché, simplemente realizamos el filtrado
            let combinedMoves = filterAndCombineMoves(forPokemonId: pokemonId)
            completion(combinedMoves)
        }
    }
    
    // Cargar y almacenar en caché tanto los movimientos del Pokémon como los detalles de los movimientos
    private func loadAllData(completion: @escaping (Bool) -> Void) {
        var pokemonMovesLoaded = false
        var moveDetailsLoaded = false

        // Cargar los movimientos del Pokémon (primer archivo)
        JSONManager.shared.load(fileName: "PokemonMoves", as: PokemonMovesResponse.self) { result in
            switch result {
            case .success(let response):
                self.pokemonMovesCache = response.pokemon
                pokemonMovesLoaded = true
                if moveDetailsLoaded {
                    self.dataLoaded = true
                    completion(true)
                }
            case .failure(let error):
                print("Error loading Pokémon moves: \(error)")
                completion(false)
            }
        }

        // Cargar los detalles de los movimientos (segundo archivo)
        JSONManager.shared.load(fileName: "MoveDetails", as: MoveDetailsResponse.self) { result in
            switch result {
            case .success(let response):
                self.moveDetailsCache = response.moves
                moveDetailsLoaded = true
                if pokemonMovesLoaded {
                    self.dataLoaded = true
                    completion(true)
                }
            case .failure(let error):
                print("Error loading move details: \(error)")
                completion(false)
            }
        }
    }

    // Combinar los movimientos del Pokémon con los detalles almacenados en caché
    private func filterAndCombineMoves(forPokemonId pokemonId: Int) -> [PokemonMoveDetail] {
        guard let pokemon = pokemonMovesCache.first(where: { $0.id == pokemonId }) else {
            return []
        }
        
        // Combinar los movimientos del Pokémon con los detalles de los movimientos
        return pokemon.moves.compactMap { pokemonMove in
            if let moveDetail = moveDetailsCache.first(where: { $0.id == pokemonMove.moveId }) {
                return PokemonMoveDetail(move: pokemonMove, detail: moveDetail)
            }
            return nil
        }
    }
}
// Estructura combinada de los detalles de los movimientos y los movimientos del Pokémon
struct PokemonMoveDetail {
    let move: PokemonMove
    let detail: MoveDetail
}
