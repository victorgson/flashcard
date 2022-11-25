//
//  PageSheetViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-25.
//

import UIKit
import Combine

protocol PageSheetDelegate {
    func onCreatePressed(deckName: String?, frontText: String?, backText: String?)
    func onDismiss()
}

class PageSheetViewController: UIViewController {
    
    let db = DBHelper()
    
    var pageSheetDelegate : PageSheetDelegate?
    
    var isDeck: Bool!
    
    let newDeckLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Create a new deck"
        label.textAlignment = .center
        return label
    }()
    
    let deckNameTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter deck name..."
        tf.borderStyle = .roundedRect
        return tf
        
    }()
    
    let frontCardTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter text for the front..."
        tf.borderStyle = .roundedRect
        return tf
        
    }()
    
    let backCardTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter text for the back..."
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
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
     init(isDeck: Bool = true){
         super.init(nibName: nil, bundle: nil)
         self.isDeck = isDeck
       if isDeck {
           self.layoutForDeck()
       } else {
           self.layoutForCard()
       }
        
   }
   
    
    required init?(coder: NSCoder) {
        fatalError()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        createButton.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    func layoutForDeck() {
        view.addSubviews(newDeckLabel, deckNameTextField, createButton)
        view.backgroundColor = .white
        
        newDeckLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        newDeckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newDeckLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        deckNameTextField.topAnchor.constraint(equalTo: newDeckLabel.bottomAnchor, constant: 32).isActive = true
        deckNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        deckNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        deckNameTextField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        createButton.topAnchor.constraint(equalTo: deckNameTextField.bottomAnchor, constant: 32).isActive = true
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
    }
    
    func layoutForCard() {
        
        view.addSubviews(newDeckLabel, frontCardTextField, backCardTextField, createButton)
        view.backgroundColor = .white
        
        newDeckLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        newDeckLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        newDeckLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        frontCardTextField.topAnchor.constraint(equalTo: newDeckLabel.bottomAnchor, constant: 32).isActive = true
        frontCardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        frontCardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        frontCardTextField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        backCardTextField.topAnchor.constraint(equalTo: frontCardTextField.bottomAnchor, constant: 8).isActive = true
        backCardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        backCardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        backCardTextField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        createButton.topAnchor.constraint(equalTo: backCardTextField.bottomAnchor, constant: 32).isActive = true
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
    }
    
    var cardDetails: ((_ : String, _ : String) -> Void)?

    
    @objc func handleButtonPressed() {
        if isDeck {
            
            pageSheetDelegate?.onCreatePressed(deckName: deckNameTextField.text ?? "", frontText: nil, backText: nil)
        } else {
            cardDetails?(frontCardTextField.text ?? "", backCardTextField.text ?? "")
            

        }
       
        resetTextField()
        dismiss(animated: true)
    }
 
    func addDeck (deckName: String) {
        db.insertDeck(deckName: deckName)
        print(deckName)
    }
    
    func resetTextField () {
        deckNameTextField.text = ""
        frontCardTextField.text = ""
        backCardTextField.text = ""
    }
    
}
