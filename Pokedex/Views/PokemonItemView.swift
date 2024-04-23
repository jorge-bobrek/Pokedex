//
//  PokemonPageView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonItemView: View {
    @EnvironmentObject var vm: PokemonListViewModel
    let pokemon: Species.Specy
    
    var body: some View {
        HStack(spacing: 10) {
            PokemonImage(id: pokemon.id, size: 100, sprite: true)
            Text(pokemon.name.uppercased())
                .font(.custom("My Font", size: 20))
                .foregroundColor(.black)
            Spacer(minLength: 0)
            Text("#\(String(format: "%04d", pokemon.id))")
                .font(.custom("My Font", size: 20))
                .foregroundColor(.black)
        }
    }
}

struct PokemonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonItemView(pokemon: Species.Specy.template)
            .environmentObject(PokemonListViewModel())
    }
}
