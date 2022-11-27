//
//  SetsViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit

class DeckTableViewController: UITableViewController, UITableViewDragDelegate {

    var data : [DeckModel]!
    
    let db = DBHelper()
    
    let vc = PageSheetViewController(isDeck: true)
    
    let viewModel = DeckViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        db.createTable()
        reloadDbData()
        view.backgroundColor = .white
        
        viewModel.getDeck()
        
 
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.add, style: .done, target: self, action: #selector(askForDeckName))
        
        tableView.register(SetsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
        tableView.sectionHeaderHeight = 0

        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self


    }
    
 
    override func viewWillAppear(_ animated: Bool) {
      
        reloadDbData()
        tableView.reloadData()
    }
    

    @objc func askForDeckName(){

        vc.modalPresentationStyle = .pageSheet
        vc.sheetPresentationController?.detents = [.medium()]
        
        navigationController?.present(vc, animated: true)
    }

    
    func addDeck (deckName: String) {
        db.insertDeck(deckName: deckName)
        reloadDbData()
        tableView.reloadData()
    }
    
    func reloadDbData(){
//        data = viewModel.
        data = db.selectDeck()?.reversed()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = Int(data[indexPath.row].id)
        print(index)
        let vc = FlashCardViewController(deckId: index)
        self.navigationController?.pushViewController(vc, animated: true)
 
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let index = data[indexPath.row].id
            
            db.deleteDeck(index: index)
            reloadDbData()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mover = data.remove(at: sourceIndexPath.row)
 
        data.insert(mover, at: destinationIndexPath.row)
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SetsTableViewCell
        cell.titleLabel.text = data[indexPath.row].deckName

        db.selectCardsInDeck(deckId: data[indexPath.row].id) { (result) -> () in
            cell.termsLabel.text = String(result.count) + " card/s"
        }
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = data[indexPath.section]
           return [ dragItem ]
    }

}
