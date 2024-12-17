//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/03/23.
//

import SwiftUI
import Combine
import Foundation

@main
 struct PokedexApp: App {
    @StateObject var languageManager = LanguageManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: PokemonListViewModel(languageManager))
                .environmentObject(languageManager)
        }
    }
}
