//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 31/03/23.
//

import SwiftUI

struct PokemonInformation: View {
    @EnvironmentObject private var appViewModel: InfoManager
    @State private var selection = 0
    let species: PokemonSpeciesDetail
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
                            LanguageText(of: form.names)
                                .detailedText(size: .Detail)
                                .id("top")
                            PokemonImage(name: "\(species.name)-\(form.name)", size: 300, endpoint: .pokemon)
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
                    LanguageText(of: species.speciesNames)
                        .detailedText(size: .Detail)
                        .id("top")
                    PokemonImage(name: species.name, size: 300, endpoint: .pokemon)
                }
                .frame(height: 360)
                .padding()
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                Text("Types")
                    .detailedText(size: .Info)
                HStack {
                    ForEach(details.pokemonTypes) { type in
                        if let monType = MonType[type.id] {
                            LanguageText(of: type.typeName)
                                .detailedText(size: .Typing)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .frame(width: 90, height: 30)
                                .background(Color(UIColor(named: monType) ?? .white))
                                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                                .pixelRoundedBorder(cornerRadius: 4)
                        }
                    }
                }
                
                Text(details.pokemonAbilities.filter({!$0.isHidden}).count > 1 ? "Abilities" : "Ability")
                    .detailedText(size: .Info)
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(details.pokemonAbilities.filter { !$0.isHidden }, id: \.id) { ability in
                        LanguageText(of: ability.name)
                            .detailedText(size: .Detail)
                            .onTapGesture {
                                withAnimation { appViewModel.currentInfo = InfoLanguage(title: ability.name, flavor: ability.flavor) }
                            }
                    }
                }
                let hidden = details.pokemonAbilities.filter({ $0.isHidden })
                if hidden.count > 0 {
                    Text("Hid. Ability")
                        .detailedText(size: .Info)
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(hidden, id: \.id) { ability in
                            LanguageText(of: ability.name)
                                .detailedText(size: .Detail)
                                .onTapGesture {
                                    withAnimation { appViewModel.currentInfo = InfoLanguage(title: ability.name, flavor: ability.flavor) }
                                }
                            
                        }
                    }
                }
                
                Text("Gender ratio")
                    .detailedText(size: .Info)
                GenderRate(rate: species.genderRate)
                
                Text("Color")
                    .detailedText(size: .Info)
                LanguageText(of: species.color.name)
                    .detailedText(size: .Detail)
                
                Text("Egg Group")
                    .detailedText(size: .Info)
                VStack(alignment: .leading) {
                    ForEach(species.eggGroups, id: \.id) { group in
                        LanguageText(of: group.name)
                            .detailedText(size: .Detail)
                    }
                }
                
                Text("Height")
                    .detailedText(size: .Info)
                Text(String(format: "%.1f m", Double(details.height)/10))
                    .detailedText(size: .Detail)
                
                Text("Weight")
                    .detailedText(size: .Info)
                Text(String(format: "%.1f kg", Double(details.weight)/10))
                    .detailedText(size: .Detail)
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
                .pixelRoundedBorder(cornerRadius: 4, borderColor: .primary)
                HStack(alignment: .center) {
                    if rate == -1 {
                        Text("Gender unknown")
                            .detailedText(size: .Hint)
                    } else if rate == 0 {
                        Text("Always male ♂")
                            .detailedText(size: .Hint)
                    } else if rate == 8 {
                        Text("Always female ♀")
                            .detailedText(size: .Hint)
                    } else {
                        InfoText("\(calculate(rate))% ♂")
                            .detailedText(size: .Hint)
                        InfoText("\(calculate(8 - rate))% ♀")
                            .detailedText(size: .Hint)
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
        PokemonInformation(species: PokemonSpeciesDetail.template, details: PokemonDetail.mew)
            .environmentObject(LanguageManager())
    }
}
