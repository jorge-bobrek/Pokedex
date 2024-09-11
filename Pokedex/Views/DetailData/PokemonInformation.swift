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
    
    var body: some View {
        Grid(alignment: .leading, verticalSpacing: 10) {
            GridRow {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 0)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 0)
            }
            GridRow {
                DetailText("Tipos", .Detail)
                HStack {
                    ForEach(details.types, id: \.type.id) { type in
                        TypeText(type.type.id, type: languageManager.getLanguage(from: type.type.typeNames))
                    }
                }
            }
            GridRow {
                DetailText(details.abilities.filter({!$0.isHidden}).count > 1 ? "Habilidades" : "Habilidad", .Detail)
                VStack(alignment: .leading) {
                    ForEach(details.abilities.filter { !$0.isHidden }, id: \.id) { ability in
                        DetailText(languageManager.getLanguage(from: ability.ability.abilityNames), .Info)
                    }
                }
            }
            GridRow {
                DetailText("Hab. Oculta", .Detail)
                ForEach(details.abilities.filter { $0.isHidden }, id: \.id) { ability in
                    DetailText(languageManager.getLanguage(from: ability.ability.abilityNames), .Info)
                }
            }
            GridRow {
                DetailText("Rat. Captura", .Detail)
                DetailText(String(details.species.captureRate), .Info)
            }
            GridRow {
                DetailText("Rat. Género", .Detail)
                GenderRate(rate: details.species.genderRate)
            }
            GridRow {
                DetailText("Ciclos ecl.", .Detail)
                DetailText(String(details.species.hatchCounter ?? 0), .Info)
            }
            GridRow {
                DetailText("Color", .Detail)
                DetailText(languageManager.getLanguage(from: details.species.color.colorNames), .Info)
            }
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
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 16,
                                    bottomLeadingRadius: 16,
                                    bottomTrailingRadius: 16,
                                    topTrailingRadius: 16
                                )
                            )
                    } else {
                        Rectangle()
                            .fill(.cyan)
                            .frame(width: CGFloat(128 / 8 * (8 - rate)), height: 10)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 16,
                                    bottomLeadingRadius: 16,
                                    bottomTrailingRadius: 8 - rate == 8 ? 16 : 0,
                                    topTrailingRadius: 8 - rate == 8 ? 16 : 0
                                )
                            )
                        Rectangle()
                            .fill(.pink)
                            .frame(width: CGFloat(128 / 8 * rate), height: 10)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: rate == 8 ? 16 : 0,
                                    bottomLeadingRadius: rate == 8 ? 16 : 0,
                                    bottomTrailingRadius: 16,
                                    topTrailingRadius: 16
                                )
                            )
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

