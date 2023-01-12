//
//  DBCardHelper.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2023-01-11.
//

import Foundation
import SQLite

class DBCardHelper : DBCardProtocol {
    
    typealias Model = CardModel
    
    var helper = DBHelper()
    var db : Connection
    
    init() {
        db = helper.database!
    }
    
    func add(model: CardModel) {
        do {
            
            // Måste ta in deckId här så jag vet var jag ska spara kortet
            try db.run(helper.flashcards.insert(helper.frontText <- model.frontCardString, helper.backText <- model.backCardString, helper.deckId <- model.id, helper.isCompleted <- false))
        } catch {
            print(error)
        }
    }
    
    func delete(model: CardModel) {
        do {
            let cardToDelete = helper.flashcards.filter(helper.id == model.id)
            try db.run(cardToDelete.delete())
        } catch {
            print(error)
        }
    }
    
    func update(model: CardModel) {
        do {
            let cardToUpdate = helper.flashcards.filter(helper.id == model.id)
            try db.run(cardToUpdate.update(helper.frontText <- model.frontCardString, helper.backText <- model.backCardString))
        } catch {
            print("update failed: \(error)")
        }
    }
    
    func update(complete: Bool, id: Int) {
        do {
            let cardToUpdate = helper.flashcards.filter(helper.id == id)
            try db.run(cardToUpdate.update(helper.isCompleted <- complete))
        } catch {
            print("update failed: \(error)")
        }
    }
    
    func getItem(id: Int, completion: (CardModel) -> Void) {
        do {
            for card in try db.prepare(helper.flashcards.where(helper.id == id)) {
                completion(CardModel(id: card[helper.id], frontCardString: card[helper.frontText], backCardString: card[helper.backText], isCompleted: card[helper.isCompleted]))
            }
        } catch {
            print(error)
        }
    }
    
    func getItems(deckId: Int, completion: ([CardModel]) -> Void) {
        var data: [CardModel] = []
        do {
            for card in try db.prepare(helper.flashcards.where(helper.deckId == deckId)) {
                let newCard = CardModel(id: card[helper.id], frontCardString: card[helper.frontText], backCardString: card[helper.backText], isCompleted: card[helper.isCompleted])
                data.append(newCard)
            }
            
        } catch {
            print(error)
        }
        completion(data)
    }
    
    func getItems(completion: ([CardModel]) -> Void) {
        // N/A
    }
    func updateCompleted(cardId: Int, isCompleted: Bool) {
        // To be implemented
    }
    
}

