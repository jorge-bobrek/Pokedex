//
//  LanguageManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 8/09/24.
//

import Foundation

class LanguageManager: ObservableObject {
    @Published var selectedLanguage: Language
    @Published var evolution: Evolution? = nil
    
    init() {
        self.selectedLanguage = Language(rawValue: UserDefaults.standard.integer(forKey: "language")) ?? .english
    }
    
    // Cambiar el idioma utilizando el enum Language
    func changeLanguage(to language: Language) {
        selectedLanguage = language
    }
    
    func getLanguage(from names: [LanguageModel]?) -> String {
        if selectedLanguage == .roomaji {
            return (names?.first(where: { $0.id == Language.jaHrkt.rawValue })?.name ?? "").applyingTransform(.toLatin, reverse: false) ?? "Traducción no disponible"
        }
        return names?.first(where: { $0.id == selectedLanguage.rawValue })?.name ?? "Traducción no disponible"
    }
}

let Flags: [String] = ["🇯🇵", "🇯🇵", "🇰🇷", "🇨🇳", "🇫🇷", "🇩🇪", "🇪🇸", "🇮🇹", "🇺🇸"]

enum Language: Int, CaseIterable {
    case jaHrkt = 1
    case roomaji = 2
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
                .roomaji: "昼",
                .korean: "낮",
                .zhHant: "日",
                .french: "Jour",
                .deutsch: "Tag",
                .spanish: "Día",
                .italian: "Giorno",
                .english: "Day"
            ],
            "night": [
                .jaHrkt: "夜",
                .roomaji: "夜",
                .korean: "밤",
                .zhHant: "夜",
                .french: "Nuit",
                .deutsch: "Nacht",
                .spanish: "Noche",
                .italian: "Notte",
                .english: "Night"
            ]
        ]
        guard let dayTranslations = translations[self.rawValue] else { return [] }
        return dayTranslations.map { (language, translation) in
            LanguageModel(id: language.rawValue, name: translation)
        }
    }
}
