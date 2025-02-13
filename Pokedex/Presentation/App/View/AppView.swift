//
//  AppView.swift
//  LingoDex
//
//  Created by Jorge Bobrek on 11/02/25.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @StateObject private var appViewModel: InfoManager = InfoManager()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                NavigationView {
                    VStack(spacing: 0) {
                        TopView()
                        PokemonListView(viewModel: PokemonListViewModel())
                    }
                    .background(Color(.secondarySystemBackground))
                }
                .environmentObject(appViewModel)
                if let info = appViewModel.currentInfo {
                    ZStack {
                        Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.opacity)
                            .onTapGesture {
                                withAnimation { appViewModel.currentInfo = nil }
                            }
                        Info(info)
                            .transition(.scale)
                    }
                }
            }
            Divider()
            BottomView()
                .background(Color(.secondarySystemBackground))
        }
        .ignoresSafeArea(.keyboard)
    }
    
    
    
    private struct Info: View {
        let info: InfoLanguage
        
        init(_ info: InfoLanguage) {
            self.info = info
        }
        
        var body: some View {
            VStack(alignment: .center, spacing: 20) {
                LanguageText(of: info.title)
                    .detailedText(size: .Detail)
                LanguageText(of: info.flavor)
                    .detailedText(size: .Typing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .pixelRoundedBorder(cornerRadius: 4, borderColor: .primary, fillColor: Color(.systemBackground))
            .padding()
        }
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

