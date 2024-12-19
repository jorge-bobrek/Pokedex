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
                .frame(width: size, height: size)
        } placeholder: {
            ProgressView()
                .frame(width: size, height: size)
        }
    }
}

struct PokemonImage: View {
    let id: Int
    let size: Double
    let onAppear: (() -> Void)?
    
    init(id: Int, size: Double, onAppear: (() -> Void)? = nil) {
        self.id = id
        self.size = size
        self.onAppear = onAppear
    }
    
    var body: some View{
        Image("Sprites/\(id)")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
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

struct DetailLanguageText: View {
    @StateObject var languageManager = LanguageManager.shared
    let names: [LanguageModel]?
    let size: Size
    
    init(of names: [LanguageModel]?,_ size: Size) {
        self.names = names
        self.size = size
    }
    
    var body: some View{
        DetailText(languageManager.getLanguage(from: names), size)
    }
}

struct DetailText: View {
    @StateObject var languageManager = LanguageManager.shared
    let text: String
    let size: Size
    
    init(_ text: String,_ size: Size) {
        self.text = text
        self.size = size
    }
    
    var body: some View{
        Text(languageManager.latinToggle ? text.applyingTransform(.toLatin, reverse: false)?.uppercased() ?? text.uppercased() : text.uppercased())
            .font(.custom("Pokemon Regular", size: size.rawValue))
            .lineLimit(2)
    }
}

enum Size: CGFloat {
    case Title = 30
    case Info = 22
    case Detail = 20
    case Typing = 16
    case Hint = 12
    case Table = 10
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
    1: "hp",
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
            .foregroundColor(color)
            content
        }
    }
}

private struct BorderBackground: ViewModifier {
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content.background(
            RoundedRectangle(cornerRadius: radius)
                .stroke(.primary)
                .background(
                    RoundedRectangle(cornerRadius: radius)
                        .fill(.background)
                )
        )
    }
}

extension View {
    func stroke(color: Color = .primary, width: CGFloat = 1) -> some View {
        modifier(Stroke(width: width, color: color))
    }
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    func borderBackground(cornerRadius: CGFloat = 0) -> some View {
        modifier(BorderBackground(radius: cornerRadius))
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
