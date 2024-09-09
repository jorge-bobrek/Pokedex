//
//  LanguageManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 8/09/24.
//

import Foundation

class LanguageManager: ObservableObject {
    @Published var selectedLanguage: Language = .english
    private var romaji = true
    
    // Cambiar el idioma utilizando el enum Language
    func changeLanguage(to language: Language) {
        if language == .jaHrkt { romaji.toggle() } else { romaji = true }
        selectedLanguage = language
    }
    
    func getLanguage(from names: [LanguageModel]?) -> String {
        if selectedLanguage == .jaHrkt && romaji {
            return (names?.first(where: { $0.id == Language.jaHrkt.rawValue })?.name ?? "").applyingTransform(.toLatin, reverse: false) ?? ""
        }
        return names?.first(where: { $0.id == selectedLanguage.rawValue })?.name ?? ""
    }
}
let Flags: [String] = ["🇯🇵", "🇰🇷", "🇨🇳", "🇫🇷", "🇩🇪", "🇪🇸", "🇮🇹", "🇺🇸"]
enum Language: Int, CaseIterable {
    case jaHrkt = 1
    case korean = 3
    case zhHant = 4
    case french = 5
    case deutsch = 6
    case spanish = 7
    case italian = 8
    case english = 9
}
