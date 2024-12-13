//
//  Helpers.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import Foundation

extension Bundle {    
    func getSpriteArtwork(for id: Int,_ canBeShiny: Bool = false) -> URL?  {
        let isShiny = Int.random(in: 1...4096) == 1 && canBeShiny
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(isShiny ? "shiny/" : "")\(id).png")
    }
}
