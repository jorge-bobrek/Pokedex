//
//  UIUtils.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/03/23.
//

import SwiftUI

struct PokemonImage: View {
    let url: String
    let size: Double
    
    init(url: String, size: Double) {
        self.url = url
        self.size = size
    }
    
    var body: some View{
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
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

struct TypeText: View {
    let index: Int
    let type: String
    
    init(_ index: Int, type: String) {
        self.index = index
        self.type = type
    }
    
    var body: some View {
        if let monType = MonType[index] {
            DetailText(type, .Typing)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .frame(width: 80, height: 24)
                .background(Color(UIColor(named: monType) ?? .white))
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(.white, lineWidth: 1))
                .shadow(color: .gray, radius: 1)
        }
        
    }
    
    struct TypeText_Previews: PreviewProvider {
        static var previews: some View {
            TypeText(2, type: "Lucha")
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
            .lineLimit(2)
    }
}

enum Size: CGFloat {
    case Title = 30
    case Detail = 26
    case Info = 22
    case Typing = 16
    case Hint = 12
}

let MonType = [
    1: "normal",
    2: "fighting",
    3: "flying",
    4: "poison",
    5: "ground",
    6: "rock",
    7: "bug",
    8: "ghost",
    9: "steel",
    10: "fire",
    11: "water",
    12: "grass",
    13: "electric",
    14: "psychic",
    15: "ice",
    16: "dragon",
    17: "dark",
    18: "fairy",
]
