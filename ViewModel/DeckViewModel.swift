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
    
    func numberOfCards() -> Int {
        return data.count
    }
}
