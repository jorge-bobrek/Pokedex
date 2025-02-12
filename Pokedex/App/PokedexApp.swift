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
    @StateObject private var languageManager: LanguageManager = LanguageManager()
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(languageManager)
        }
    }
}
