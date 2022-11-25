//
//  CardViewModel.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-25.
//

import Foundation
import Combine

class CardViewModel {
    
    let db = DBHelper()
    @Published var data: [CardModel] = []
    
    func getCards(inDeck: Int)  {
        db.selectCardsInDeck(deckId: inDeck) { (result) -> () in
            data = result
            print(result)
        }
    }
    
    
    func numberOfCards() -> Int {
        return data.count
    }
    
    
}
