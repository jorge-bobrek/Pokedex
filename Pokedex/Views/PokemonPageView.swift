//
//  PokemonPageView.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/03/23.
//

import SwiftUI

struct PokemonPageView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: PokemonPage
    let dimensions: Double = 100
    
    var body: some View {
        HStack(spacing: 10) {
            pokemonImage(id: vm.getPokemonIndex(pokemon: pokemon), size: dimensions)
            Text(pokemon.name.uppercased())
                .font(.custom("My Font", size: 20))
                .foregroundColor(.black)
            Spacer(minLength: 0)
            Text("#\(String(format: "%03d", vm.getPokemonIndex(pokemon: pokemon)))")
                .font(.custom("My Font", size: 20))
                .foregroundColor(.black)
        }
    }
}

struct PokemonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPageView(pokemon: PokemonPage.example)
            .environmentObject(ViewModel())
    }
}
