//
//  UIUtils.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 23/03/23.
//

import SwiftUI

struct PokemonURLImage: View {
    let url: URL
    let size: Double
    
    init(url: URL, size: Double) {
        self.url = url
        self.size = size
    }
    
    var body: some View{
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size, alignment: .center)
        } placeholder: {            
            SkeletonView(cellFrame: (size, size), cornerRadius: 8)
        }
    }
}

struct PokemonImage: View {
    let name: String
    let size: Double
    let endpoint: SpriteEndpoint
    
    var body: some View {
        AsyncCachedImage(url: URL(string: "http://149.130.182.84:26999/sprites\(endpoint.rawValue)/\(name).png")) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        } loading: {
            SkeletonView(cellFrame: (size-(size/8), size-(size/8)), cornerRadius: size/8)
                .frame(width: size, height: size)
        } placeholder: {
            Image(endpoint == .pokemon ? "missingno" : "missingitem")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
    }
}
struct ItemImage: View {
    let name: String
    let size: Double
    
    var body: some View {
        AsyncImage(url: URL(string: "http://149.130.182.84:26999/sprites\(SpriteEndpoint.item.rawValue)/\(name).png")) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        } placeholder: {
            SkeletonView(cellFrame: (size-(size/8), size-(size/8)), cornerRadius: size/8)
                .frame(width: size, height: size)
        }
    }
}

enum SpriteEndpoint: String {
    case pokemon = "/pokemon"
    case item = "/item"
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

struct InfoText: View {
    let info: String
    
    init(_ info: String) {
        self.info = info
    }
    
    var body: some View{
        Text(info)
    }
}

struct LanguageText: View {
    @EnvironmentObject private var languageManager: LanguageManager
    let names: [LanguageModel]?
    
    init(of names: [LanguageModel]?) {
        self.names = names
    }
    
    var body: some View{
        Text(languageManager.getLanguage(from: names))
    }
}

enum Size: CGFloat {
    case Title = 36
    case Info = 32
    case Detail = 28
    case Typing = 24
    case Text = 20
    case Hint = 16
    case Table = 14
}

let MonType: [Int: String] = [
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

let Stat: [Int: String] = [
    1: "hp ",
    2: "atk",
    3: "def",
    4: "spa",
    5: "spd",
    6: "spe"
]

private struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner
    
    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

private struct Stroke: ViewModifier {
    var width: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack{
            ZStack{
                content.offset(x:  width, y:  width)
                content.offset(x: -width, y: -width)
                content.offset(x: -width, y:  width)
                content.offset(x:  width, y: -width)
            }
            .foregroundStyle(color)
            content
        }
    }
}

private struct DetailText: ViewModifier {
    let size: Size
    
    func body(content: Content) -> some View {
        content
            .font(.custom("PokemonDPPt", size: size.rawValue))
            .textCase(.uppercase)
    }
}

extension View {
    func stroke(color: Color = .primary, width: CGFloat = 1) -> some View {
        modifier(Stroke(width: width, color: color))
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    func detailedText(size: Size) -> some View {
        modifier(DetailText(size: size))
    }
    
    @ViewBuilder
    private func onTapBackgroundContent(enabled: Bool, _ action: @escaping () -> Void) -> some View {
        if enabled {
            Color.clear
                .frame(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2)
                .contentShape(Rectangle())
                .onTapGesture(perform: action)
        }
    }
    func onTapBackground(enabled: Bool, _ action: @escaping () -> Void) -> some View {
        background(
            onTapBackgroundContent(enabled: enabled, action)
        )
    }
}
