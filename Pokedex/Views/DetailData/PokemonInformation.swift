//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//
import SwiftUI

struct PokemonInformation: View {
    let details: PokemonDetail
    
    // Definir las columnas para la cuadrícula
    let columns = [
        GridItem(.fixed(150), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {            
            // Tipos de Pokémon
            DetailText("Tipos", .Info)
            HStack {
                ForEach(details.types, id: \.type.id) { type in
                    if let monType = MonType[type.type.id] {
                        DetailLanguageText(of: type.type.typeNames, .Typing)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .frame(width: 90, height: 30)
                            .background(Color(UIColor(named: monType) ?? .white))
                            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                            .shadow(color: .gray, radius: 1)
                            .stroke()
                    }
                }
            }
            
            // Habilidades visibles
            DetailText(details.abilities.filter({!$0.isHidden}).count > 1 ? "Habilidades" : "Habilidad", .Info)
            VStack(alignment: .leading) {
                ForEach(details.abilities.filter { !$0.isHidden }, id: \.id) { ability in
                    DetailLanguageText(of: ability.ability.abilityNames, .Detail)
                }
            }
            
            // Habilidad oculta
            let hidden = details.abilities.filter({ $0.isHidden })
            if hidden.count > 0 {
                DetailText("Hab. Oculta", .Info)
                VStack(alignment: .leading) {
                    ForEach(hidden, id: \.id) { ability in
                        DetailLanguageText(of: ability.ability.abilityNames, .Detail)
                    }
                }
            }
            
            // Tasa de captura
            // DetailText("Rat. Captura", .Info)
            // DetailText(String(details.species.captureRate), .Detail)
            
            // Tasa de género
            DetailText("Rat. Género", .Info)
            GenderRate(rate: details.species.genderRate)
            
            // Ciclos de eclosión
            // DetailText("Ciclos ecl.", .Info)
            // DetailText(String(details.species.hatchCounter ?? 0), .Detail)
            
            // Color
            DetailText("Color", .Info)
            DetailLanguageText(of: details.species.color.colorNames, .Detail)
        }
    }
    
    private struct GenderRate: View {
        let rate: Int
        
        var body: some View {
            VStack {
                HStack(spacing: 1) {
                    if rate == -1 {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 128, height: 10)
                            .cornerRadius(16, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight])
                    } else {
                        Rectangle()
                            .fill(.cyan)
                            .frame(width: CGFloat(128 / 8 * (8 - rate)), height: 10)
                            .cornerRadius(16, corners: [.topLeft, .bottomLeft])
                            .cornerRadius(8 - rate == 8 ? 16 : 0, corners: [.topRight, .bottomRight])
                        Rectangle()
                            .fill(.pink)
                            .frame(width: CGFloat(128 / 8 * rate), height: 10)
                            .cornerRadius(rate == 8 ? 16 : 0, corners: [.topLeft, .bottomLeft])
                            .cornerRadius(16, corners: [.topRight, .bottomRight])
                    }
                }
                HStack(alignment: .center) {
                    if rate == -1 {
                        DetailText("No tiene género", .Hint)
                    } else if rate == 0 {
                        DetailText("Siempre es macho ♂", .Hint)
                    } else if rate == 8 {
                        DetailText("Siempre es hembra ♀", .Hint)
                    } else {
                        DetailText("\(calculate(rate))% ♂", .Hint)
                        DetailText("\(calculate(8 - rate))% ♀", .Hint)
                    }
                }
            }
        }
        
        private func calculate(_ rate: Int) -> String {
            let percent = 100.0 / 8.0 * Float(rate)
            return String(format: "%g", 100 - percent)
        }
    }
}

struct PokemonInformation_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInformation(details: PokemonDetail.template)
            .environmentObject(LanguageManager())
    }
}
