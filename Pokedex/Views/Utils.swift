//
//  Utils.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/03/23.
//

import SwiftUI

struct PokemonImage: View {
    let id: Int
    let size: Double
    let sprite: Bool
    
    init(id: Int, size: Double, sprite: Bool = false) {
        self.id = id
        self.size = size
        self.sprite = sprite
    }
    
    var body: some View{
        AsyncImage(url: URL(string: sprite ? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png" : "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")) { image in
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            }
        } placeholder: {
            ProgressView()
                .frame(width: size, height: size)
        }
    }
}

struct TypeImage: View {
    let type: String
    
    init(_ type: String) {
        self.type = type
    }
    
    var body: some View{
        if UIImage(named: type) != nil {
            Image(type)
                .resizable()
                .frame(width: 32, height: 32)
        } else {
            Text(type.uppercased())
        }
    }
}

struct DetailText: View {
    let text: String
    let size: Size
    
    init(_ text: String,_ size: Size) {
        self.text = text
        self.size = size
    }
    
    var body: some View{
        Text(text.uppercased())
            .font(.custom("My Font", size: size.rawValue))
    }
}

enum Size: CGFloat {
    case Title = 30
    case Detail = 26
    case Info = 22
}
