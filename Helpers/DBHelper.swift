//
//  databaseService.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-18.
//

import Foundation
import SQLite3

enum SQLiteError: Error {
    case OpenDatabase(message: String)
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
}

class DBHelper {
    var db : OpaquePointer?
    var path : String = "myDb.sqlite"
    init() {
        self.db = createDB()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path(), &db) != SQLITE_OK {
            print("Error creating DB")
            return nil
        } else {
            print("Database has been created with path \(path)")
            return db
        }
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS deck(id INTEGER PRIMARY KEY AUTOINCREMENT, deckName TEXT);"
        
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table has been created")
            } else {
                print("Table creation failed")
            }
            
        } else {
            print("Preparation failed")
        }
        
    }
    
    
}
