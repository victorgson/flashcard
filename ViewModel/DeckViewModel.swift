//
//  DeckViewModel.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-25.
//

import Foundation

class DeckViewModel {
    
//    let db = DBHelper()
    let db = DBDeckHelper()
    @Published var data: [DeckModel] = []
    
    func getAllDecks() {
        db.getItems { decks in
            data = decks
        }
   
    }
    
    func deleteDeck(withId: Int) {
        let deckToDelete = data.first(where: {$0.id == withId})
        
        if let deck = deckToDelete {
            db.delete(deckId: withId, model: deck)
        }
        
        
    }
    
    func numberOfCardsIn(deck: Int) -> Int {
        var amountOfCards: Int = 0
        return amountOfCards
    }
    
    func addDeck(deckName: String) {
        db.add(model: DeckModel(id: 1 , deckName: deckName ) )
    }
    
    func numberOfDecks() -> Int {
        return data.count
    }
}
