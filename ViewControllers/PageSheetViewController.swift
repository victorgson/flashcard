//
//  PageSheetViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-25.
//

import UIKit

class PageSheetViewController: UIViewController {
    
    let db = DBHelper()
    
    let newDeckLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Create a new deck"
        label.textAlignment = .center
        return label
    }()
    
    let textField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter deck name..."
        tf.borderStyle = .roundedRect
        return tf
        
    }()
    
    let createButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Create deck", for: .normal)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        createButton.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        layout()
        // Do any additional setup after loading the view.
    }
    
    func layout() {
        view.addSubviews(newDeckLabel, textField, createButton)
        view.backgroundColor = .white
        
        newDeckLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        newDeckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newDeckLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        textField.topAnchor.constraint(equalTo: newDeckLabel.bottomAnchor, constant: 32).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        createButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32).isActive = true
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
    }
    
    @objc func handleButtonPressed() {
        addDeck(deckName: textField.text ?? "default")
    }
 
    func addDeck (deckName: String) {
        db.insertDeck(deckName: deckName)
        print(deckName)
        
        
        
 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
