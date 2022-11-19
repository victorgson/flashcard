//
//  databaseService.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-18.
//

import Foundation
import SQLite


class DBHelper {
    
    let decks = Table("decks")
    let id = Expression<Int64>("id")
    let name = Expression<String>("deckName")
    
    let flashcards = Table("cards")
    let deckId = Expression<Int64>("deckId")
    let frontText = Expression<String>("frontText")
    let backText = Expression<String>("backText")
    
    
    func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return
        }
        
        do{
            try database.run(decks.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(name)
            })
            
            try database.run(flashcards.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(frontText)
                t.column(backText)
                t.column(deckId)
                t.foreignKey(deckId, references: decks, id)
            })
                
        } catch {
            print(error)
            
        }
    }
    
    func insertDeck(deckName: String) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return
        }
        do {
            try database.run(decks.insert(name <- deckName))
        } catch {
            print(error)
        }
        
    }
    
    func insertCard(front: String, back: String, deck: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return
        }
        do {
            try database.run(flashcards.insert(frontText <- front, backText <- back, deckId <- Int64(deck)))
        } catch {
            print(error)
        }
        
    }
    
    func selectDeck() -> [DeckModel]? {
        var data: [DeckModel] = []
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return nil
        }
        
        do {
            for deck in try database.prepare(decks) {
                let newDeck = DeckModel(id: deck[id], deckName: deck[name])
                data.append(newDeck)
//                print("id: \(deck[id]), name: \(deck[name])")
            }
        } catch {
            print(error)
        }
        
        return data
    }
    
    func selectCards() -> [CardModel]? {
        var data: [CardModel] = []
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return nil
        }
        
        do {
            for card in try database.prepare(flashcards) {
                let newDeck = CardModel(id: card[id], frontCardString: card[frontText], backCardString: card[backText])
                data.append(newDeck)

            }
        } catch {
            print(error)
        }
        
        return data
    }
    
    func selectCards(deckId: Int) -> [CardModel]? {
        var data: [CardModel] = []
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return nil
        }
        
        do {
            for card in try database.prepare(flashcards.where(id == Int64(deckId))) {
                let newDeck = CardModel(id: card[id], frontCardString: card[frontText], backCardString: card[backText])
                data.append(newDeck)

            }
        } catch {
            print(error)
        }
        
        return data
    }
    
    func deleteDeck(index: Int64) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return
        }
        do {
            print(index)
            let deckToDelete = decks.filter(id == index)
            try database.run(deckToDelete.delete())
        } catch {
            print(error)
        }
   
    }
    
    func deleteCard(index: Int64) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Database connection error")
            return
        }
        do {
            let cardToDelete = flashcards.filter(id == index)
            try database.run(cardToDelete.delete())
        } catch {
            print(error)
        }
   
    }
    
}



