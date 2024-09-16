//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//
import SwiftUI

struct PokemonInformation: View {
    @EnvironmentObject var languageManager: LanguageManager
    let details: PokemonDetail
    
    // Definir las columnas para la cuadrícula
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {            
            // Tipos de Pokémon
            DetailText("Tipos", .Info)
            HStack {
                ForEach(details.types, id: \.type.id) { type in
                    TypeText(type.type.id, type: languageManager.getLanguage(from: type.type.typeNames))
                }
            }
            
            // Habilidades visibles
            DetailText(details.abilities.filter({!$0.isHidden}).count > 1 ? "Habilidades" : "Habilidad", .Info)
            VStack(alignment: .leading) {
                ForEach(details.abilities.filter { !$0.isHidden }, id: \.id) { ability in
                    DetailText(languageManager.getLanguage(from: ability.ability.abilityNames), .Detail)
                }
            }
            
            // Habilidad oculta
            DetailText("Hab. Oculta", .Info)
            VStack(alignment: .leading) {
                ForEach(details.abilities.filter { $0.isHidden }, id: \.id) { ability in
                    DetailText(languageManager.getLanguage(from: ability.ability.abilityNames), .Detail)
                }
            }
            
            // Tasa de captura
            DetailText("Rat. Captura", .Info)
            DetailText(String(details.species.captureRate), .Detail)
            
            // Tasa de género
            DetailText("Rat. Género", .Info)
            GenderRate(rate: details.species.genderRate)
            
            // Ciclos de eclosión
            DetailText("Ciclos ecl.", .Info)
            DetailText(String(details.species.hatchCounter ?? 0), .Detail)
            
            // Color
            DetailText("Color", .Info)
            DetailText(languageManager.getLanguage(from: details.species.color.colorNames), .Detail)
        }
        .padding()
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
    }
}
