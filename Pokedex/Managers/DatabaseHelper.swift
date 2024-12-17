//
//  DatabaseHelper.swift
//  Pokedex
//
//  Created by Jorge Bobrek on 17/12/24.
//

import Foundation
import SQLite3

class DatabaseHelper {
    static let shared = DatabaseHelper()
    var db: OpaquePointer?

    private init() {
        openDatabase()
    }

    // Abre la base de datos desde el bundle
    func openDatabase() {
        guard let dbPath = Bundle.main.path(forResource: "pokemon", ofType: "db") else {
            print("Database path not found.")
            return
        }

        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("Error opening database.")
        } else {
            print("Database opened successfully.")
        }
    }

    // Ejecutar una consulta genérica
    func executeQuery(query: String) -> OpaquePointer? {
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing query: \(query)")
            return nil
        }
        return stmt
    }

    // Cierra la base de datos
    func closeDatabase() {
        if sqlite3_close(db) != SQLITE_OK {
            print("Error closing database.")
        }
    }
}
