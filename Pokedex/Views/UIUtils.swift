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
    let onAppear: (() -> Void)?
    
    init(url: String, size: Double, onAppear: (() -> Void)? = nil) {
        self.url = url
        self.size = size
        self.onAppear = onAppear
    }
    
    var body: some View{
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .onAppear(perform: onAppear)
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
                .frame(width: 90, height: 30)
                .background(Color(UIColor(named: monType) ?? .white))
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                .shadow(color: .gray, radius: 1)
                .stroke()
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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
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

struct Stroke: ViewModifier {
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

extension View {
    func stroke(color: Color = .primary, width: CGFloat = 1) -> some View {
        modifier(Stroke(width: width, color: color))
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Define the proportion of the arrowhead to the tail
        let arrowWidth = rect.width * 0.4
        let arrowHeight = rect.height * 0.8

        // Draw the arrow tail
        path.move(to: CGPoint(x: rect.midX - arrowWidth / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + arrowWidth / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + arrowWidth / 2, y: rect.maxY - arrowHeight))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - arrowHeight))

        // Draw the arrowhead
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - arrowHeight))
        path.addLine(to: CGPoint(x: rect.midX - arrowWidth / 2, y: rect.maxY - arrowHeight))

        // Complete the path by closing the shape
        path.closeSubpath()

        return path
    }
}
