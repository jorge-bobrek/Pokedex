//
//  Network.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 22/04/24.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:8080/v1/graphql/")!)
}
