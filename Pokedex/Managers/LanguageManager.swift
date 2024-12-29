//
//  LanguageManager.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 8/09/24.
//

import Foundation
import SwiftUI

final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var selectedLanguage: Language
    @Published var latinToggle: Bool = false
    @Published var showDropdown: Bool = false
    
    private init() {
        self.selectedLanguage = Language(rawValue: UserDefaults.standard.integer(forKey: "language")) ?? .english
    }
    
    func changeLanguage(to language: Language) {
        selectedLanguage = language
    }
    
    var isLatin: Bool {
        let transform: Set<Language> = [.japanese, .korean, .chinese]
        return !transform.contains(self.selectedLanguage)
    }
    
    func getLanguage(from names: [LanguageModel]?) -> String {
        if self.latinToggle {
            return (names?.first(where: { $0.id == selectedLanguage.rawValue })?.name ?? "Traducción no disponible")
                .applyingTransform(.toLatin, reverse: false) ?? "Traducción no disponible"
        }
        return names?.first(where: { $0.id == selectedLanguage.rawValue })?.name ?? "Traducción no disponible"
    }
}

let Flags: [String] = ["🇯🇵", "?", "🇰🇷", "🇨🇳", "🇫🇷", "🇩🇪", "🇪🇸", "🇮🇹", "🇺🇸", "?", "?", "?"]

enum Language: Int, CaseIterable {
    case japanese = 1
    case korean = 3
    case chinese = 4
    case french = 5
    case deutsch = 6
    case spanish = 7
    case italian = 8
    case english = 9
}
