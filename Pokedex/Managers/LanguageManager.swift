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

enum TimeOfDay: String {
    case day = "day"
    case night = "night"
    
    func toLanguageModels() -> [LanguageModel] {
        let translations: [String: [Language: String]] = [
            "day": [
                .japanese: "昼",
                .romanji: "昼",
                .korean: "낮",
                .chinese: "日",
                .french: "Jour",
                .deutsch: "Tag",
                .spanish: "Día",
                .italian: "Giorno",
                .english: "Day"
            ],
            "night": [
                .japanese: "夜",
                .romanji: "夜",
                .korean: "밤",
                .chinese: "夜",
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
