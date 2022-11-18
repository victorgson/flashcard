//
//  SetsViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit

class SetsViewController: UITableViewController {
    
    
    var data : [DeckModel] = [DeckModel(deckName: "Test")]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.add, style: .done, target: self, action: #selector(askForDeckName))
        
        tableView.register(SetsTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
        tableView.sectionHeaderHeight = 0
    }
    
    @objc func askForDeckName(){
        let alert = UIAlertController(title: "Add new deck", message: "Enter a name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter text.."
        }
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.addDeck(deckName: textField?.text ?? "Default deck name")
        }))
    
        self.present(alert, animated: true, completion: nil)
    }

    
    func addDeck (deckName: String) {
        let newDeck = DeckModel(deckName: deckName)
        data.append(newDeck)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FlashCardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let indexSet = IndexSet(arrayLiteral: indexPath.section)
            self.data.remove(at: indexPath.section)
            tableView.deleteSections(indexSet, with: .fade)
  
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SetsTableViewCell
        cell.titleLabel.text = data[indexPath.section].deckName
        return cell
    }
}
