//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct PokemonInformation: View {
    @State private var selection = 0
    @State private var selectedAbilityId: Int? = nil
    let species: PokemonSpecies
    let details: PokemonDetail
    
    let columns = [
        GridItem(.fixed(150), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topLeading)
    ]
    
    var body: some View {
        VStack {
            if !details.pokemonForms.isEmpty {
                TabView(selection : $selection) {
                    ForEach(details.pokemonForms) { form in
                        VStack {
                            DetailText(form.flavor, .Detail)
                                .id("top")
                            PokemonImage(name: "\(species.name)-\(form.formName)", size: 300)
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(
                    .page(backgroundDisplayMode: .always)
                )
                .frame(height: 360)
                .padding()
            } else {
                VStack {
                    DetailText(species.name, .Detail)
                        .id("top")
                    PokemonImage(name: species.name, size: 300)
                }
                .frame(height: 360)
                .padding()
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                // Tipos de Pokémon
                DetailText("Tipos", .Info)
                HStack {
                    ForEach(details.pokemonTypes) { type in
                        if let monType = MonType[type.id] {
                            DetailText(type.typeName, .Typing)
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
                
                DetailText(details.pokemonAbilities.filter({!$0.isHidden}).count > 1 ? "Habilidades" : "Habilidad", .Info)
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(details.pokemonAbilities.filter { !$0.isHidden }, id: \.id) { ability in
                        AbilityInfo(ability: ability, showing: selectedAbilityId == ability.id) {
                            withAnimation { selectedAbilityId = (selectedAbilityId == ability.id) ? nil : ability.id }
                        }
                    }
                }
                let hidden = details.pokemonAbilities.filter({ $0.isHidden })
                if hidden.count > 0 {
                    DetailText("Hab. Oculta", .Info)
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(hidden, id: \.id) { ability in
                            VStack(alignment: .leading) {
                                AbilityInfo(ability: ability, showing: selectedAbilityId == ability.id) {
                                    withAnimation { selectedAbilityId = (selectedAbilityId == ability.id) ? nil : ability.id }
                                }
                            }
                        }
                    }
                }
                
                // Tasa de género
                DetailText("Rat. Género", .Info)
                GenderRate(rate: species.genderRate)
                
                // Color
                DetailText("Color", .Info)
                DetailText(species.colorName, .Detail)
                
                DetailText("Grupo Huevo", .Info)
                VStack(alignment: .leading) {
                    ForEach(species.eggGroups, id: \.id) { group in
                        DetailText(group.name, .Detail)
                    }
                }
                
                // Tamaño
                DetailText("Altura", .Info)
                DetailText("\(Double(details.height)/10) m", .Detail)
                
                DetailText("Peso", .Info)
                DetailText("\(Double(details.weight)/10) kg", .Detail)
            }
        }
    }
    
    private struct AbilityInfo: View {
        let ability: PokemonAbility
        let showing: Bool
        let onTap: () -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                DetailText(ability.name, .Detail)
                    .onTapGesture { onTap() }
                if showing {
                    DetailText(ability.flavor, .Typing)
                        .padding(4)
                        .borderBackground(cornerRadius: 4)
                        .onTapBackground(enabled: showing) { onTap() }
                        .padding(.top, 2)
                }
            }
        }
    }
    
    //.onTapBackground(
    //    enabled: showingDetails[ability.id],
    //    { withAnimation { showingDetails[ability.id] = false } }
    //)
    
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
        PokemonInformation(species: PokemonSpecies.template, details: PokemonDetail.template)
    }
}
