//
//  PokemonPageView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonItemView: View {
    let pokemon: PokemonSpeciesList
    
    var body: some View {
        HStack(spacing: 10) {
            PokemonImage(name: pokemon.name, size: 100, endpoint: .pokemon)
            Text(pokemon.name)
                .detailedText(size: .Info)
                .foregroundColor(.primary)
            Spacer(minLength: 0)
            InfoText("#\(String(format: "%04d", pokemon.id))")
                .detailedText(size: .Info)
                .foregroundColor(.primary)
        }
    }
}

struct PokemonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItemView(pokemon: PokemonSpeciesList.template)
    }
}
