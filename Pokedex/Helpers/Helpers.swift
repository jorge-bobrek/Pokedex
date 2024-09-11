//
//  Helpers.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

extension Bundle {
    func getSprite(for id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    
    func getSpriteArtwork(for id: Int, canBeShiny: Bool = false) -> String  {
        let isShiny = Int.random(in: 1...4096) == 1 && canBeShiny
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(isShiny ? "shiny/" : "")\(id).png"
    }
}
