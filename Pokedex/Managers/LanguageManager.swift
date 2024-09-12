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
            return (names?.first(where: { $0.id == Language.jaHrkt.rawValue })?.name ?? "").applyingTransform(.toLatin, reverse: false) ?? "❌"
        }
        return names?.first(where: { $0.id == selectedLanguage.rawValue })?.name ?? "❌"
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

enum TimeOfDay: String {
    case day = "day"
    case night = "night"
    
    func toLanguageModels() -> [LanguageModel] {
        let translations: [String: [Language: String]] = [
            "day": [
                .jaHrkt: "昼",
                .korean: "낮",
                .zhHant: "日",
                .french: "jour",
                .deutsch: "Tag",
                .spanish: "día",
                .italian: "giorno",
                .english: "day"
            ],
            "night": [
                .jaHrkt: "夜",
                .korean: "밤",
                .zhHant: "夜",
                .french: "nuit",
                .deutsch: "Nacht",
                .spanish: "noche",
                .italian: "notte",
                .english: "night"
            ]
        ]
        guard let dayTranslations = translations[self.rawValue] else { return [] }
        return dayTranslations.map { (language, translation) in
            LanguageModel(id: language.rawValue, name: translation)
        }
    }
}
