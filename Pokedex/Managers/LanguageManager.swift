//
//  LanguageManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 8/09/24.
//

import Foundation

class LanguageManager: ObservableObject {
    // Idioma seleccionado actualmente
    @Published var selectedLanguage: Language = .english
    
    // Cambiar el idioma utilizando el enum Language
    func changeLanguage(to language: Language) {
        selectedLanguage = language
    }
}
