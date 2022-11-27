//
//  DeckViewModel.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-25.
//

import Foundation

class DeckViewModel {
    
    let db = DBHelper()
    @Published var data: [DeckModel] = []
    
    func getDeck()  {
        db.selectDeck { (result) -> () in
            data = result
            print(result)
        }
    }
    
    func deleteDeck(withId: Int) {
        db.deleteDeck(index: withId)
    }
    
    func numberOfCardsIn(deck: Int) -> Int {
        var amountOfCards: Int = 0
        db.selectCardsInDeck(deckId: deck, completion: {(result) -> () in
            amountOfCards = result.count
        })
        return amountOfCards
    }
    
    func numberOfDecks() -> Int {
        return data.count
    }
}
