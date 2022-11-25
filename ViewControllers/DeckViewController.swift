//
//  DeckViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-25.
//

import UIKit

class DeckViewController: DeckTableViewController, PageSheetDelegate{

    
 
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.pageSheetDelegate = self

        // Do any additional setup after loading the view.
    }
    
    func onCreatePressed(deckName: String?, frontText: String?, backText: String?) {
        
        guard let deckName = deckName else {
            return
        }
        addDeck(deckName: deckName)
    }
    func onCreatePressed(deckName: String) {
     
    }
    
    func onDismiss() {
     // NA
    }

}
