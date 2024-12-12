//
//  LanguageManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 8/09/24.
//

import Foundation

class LanguageManager: ObservableObject {
    @Published var selectedLanguage: Language
    
    init() {
        self.selectedLanguage = Language(rawValue: UserDefaults.standard.integer(forKey: "language")) ?? .english
    }
    
    // Cambiar el idioma utilizando el enum Language
    func changeLanguage(to language: Language) {
        selectedLanguage = language
    }
    
    func getLanguage(from names: [LanguageModel]?) -> String {
        if selectedLanguage == .romanji {
            return (names?.first(where: { $0.id == Language.japanese.rawValue })?.name ?? "").applyingTransform(.toLatin, reverse: false) ?? "Traducción no disponible"
        }
        return names?.first(where: { $0.id == selectedLanguage.rawValue })?.name ?? "Traducción no disponible"
    }
}

let Flags: [String] = ["🇯🇵", "🇯🇵", "🇰🇷", "🇨🇳", "🇫🇷", "🇩🇪", "🇪🇸", "🇮🇹", "🇺🇸"]

enum Language: Int, CaseIterable {
    case japanese = 1
    case romanji = 2
    case korean = 3
    case chinese = 4
    case french = 5
    case deutsch = 6
    case spanish = 7
    case italian = 8
    case english = 9
}
