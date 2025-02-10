//
//  PokemonNaturesViewModel.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 4/10/24.
//

import Foundation
import SwiftUI

@MainActor
final class PokemonNaturesViewModel: ObservableObject {
    @Published var natureList = [Nature]()
    
    private let fetchNaturesUseCase: FetchNaturesUseCase
    
    init(fetchNaturesUseCase: FetchNaturesUseCase) {
        self.fetchNaturesUseCase = fetchNaturesUseCase
    }
    
    func getNatures() async {
        do {
            self.natureList = try await fetchNaturesUseCase.execute()
        } catch {
            print(error)
        }
    }
}

