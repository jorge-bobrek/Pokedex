//
//  PokemonPageView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonItemView: View {
    let pokemon: Species
    
    var body: some View {
        HStack(spacing: 10) {
            PokemonImage(id: pokemon.id, size: 100)
            DetailLanguageText(of: pokemon.names, .Info)
                .foregroundColor(.primary)
            Spacer(minLength: 0)
            DetailText("#\(String(format: "%04d", pokemon.id))", .Info)
                .foregroundColor(.primary)
        }
    }
}

struct PokemonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItemView(pokemon: Species.template)
    }
}
