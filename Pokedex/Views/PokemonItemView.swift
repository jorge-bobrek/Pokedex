//
//  PokemonPageView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonItemView: View {
    let pokemon: Species.ListSpecy
    
    var body: some View {
        HStack(spacing: 10) {
            PokemonImage(url: Bundle.main.getSprite(for: pokemon.id), size: 100)
            Text(pokemon.name.uppercased())
                .font(.custom("My Font", size: 20))
                .foregroundColor(.primary)
            Spacer(minLength: 0)
            Text("#\(String(format: "%04d", pokemon.id))")
                .font(.custom("My Font", size: 20))
                .foregroundColor(.primary)
        }
    }
}

struct PokemonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItemView(pokemon: Species.ListSpecy.template)
    }
}
