//
//  AppView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 11/02/25.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationView {
                VStack(spacing: 0) {
                    TopView()
                    PokemonListView(viewModel: PokemonListViewModel())
                }
                .background(Color(.secondarySystemBackground))
            }
            Divider()
            BottomView()
                .background(Color(.secondarySystemBackground))
        }
        .ignoresSafeArea(.keyboard)
    }
    
    
    // MARK: Top View
    struct TopView: View {
        var body: some View {
            HStack {
                NavigationLink(destination: NaturesView(viewModel: PokemonNaturesViewModel(fetchNaturesUseCase: .init()))) {
                    HStack {
                        HStack(spacing: 0) {
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: .green, location: 0.0),
                                            .init(color: .green, location: 0.5),
                                            .init(color: .red, location: 0.5),
                                            .init(color: .red, location: 1.0)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        }
                        Text("Natures")
                            .detailedText(size: .Detail)
                            .foregroundStyle(.primary)
                    }
                }
                NavigationLink(destination: ItemListView()) {
                    HStack {
                        Image(systemName: "bag.fill")
                            .foregroundStyle(.orange)
                        Text("Items")
                            .detailedText(size: .Detail)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
    
    // MARK: Bottom View
    struct BottomView: View {
        @EnvironmentObject private var languageManager: LanguageManager
        
        var body: some View {
            HStack {
                Spacer()
                let flags: [String] = ["🇯🇵", "?", "🇰🇷", "🇨🇳", "🇫🇷", "🇩🇪", "🇪🇸", "🇮🇹", "🇺🇸", "?", "?", "?"]
                PickerView(selected: $languageManager.selectedLanguage, items: Language.allCases, direction: .up) { language in
                    HStack {
                        Text("\(flags[language.rawValue - 1]) \(language)")
                            .detailedText(size: .Detail)
                        Spacer()
                    }
                    .padding(.leading, 8)
                    .frame(width: 140)
                }
                if !languageManager.isLatin {
                    Toggle(isOn: $languageManager.latinToggle) {
                        Text("To latin")
                            .detailedText(size: .Typing)
                    }
                    .frame(width: 128)
                }
                Spacer()
            }
            .padding(.top, 10)
        }
    }
    
}

