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
    
    let db = DBCardHelper()
    
    var pageSheetDelegate : PageSheetDelegate?
    
    var isDeck: Bool!
    var isEditMode: Bool!
    
    let action = PassthroughSubject<(deckName: String?, frontText: String?, backText: String?), Never>()
    let editAction = PassthroughSubject<(updatedFrontText: String?, updatedBackText: String?), Never>()
    
    let topLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        label.textAlignment = .center
        return label
    }()
    
    let deckNameTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter deck name..."
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .secondarySystemBackground
        return tf
        
    }()
    
    let frontCardTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter text for the front..."
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .secondarySystemBackground
        return tf
    }()
    
    let backCardTextField : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter text for the back..."
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .secondarySystemBackground
        return tf
    }()
    
    let createButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "AccentColor")
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(isDeck: Bool = true, isEditMode: Bool = false){
        super.init(nibName: nil, bundle: nil)
        self.isDeck = isDeck
        self.isEditMode = isEditMode
        
        if isDeck {
            self.layoutForDeck()
        } else if isEditMode {
            self.layoutForEditCard()
        }
        else {
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
        
        view.backgroundColor = .systemBackground
    }
    
    func layoutForDeck() {
        view.addSubviews(topLabel, deckNameTextField, createButton)
        
        createButton.setTitle("Create Deck", for: .normal)
        topLabel.text = "Create a new deck"
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        deckNameTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 32).isActive = true
        deckNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        deckNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        deckNameTextField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        createButton.topAnchor.constraint(equalTo: deckNameTextField.bottomAnchor, constant: 32).isActive = true
        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    func layoutForCard() {
        
        view.addSubviews(topLabel, frontCardTextField, backCardTextField, createButton)
        
        
        createButton.setTitle("Create Card", for: .normal)
        topLabel.text = "Create a new card"
        
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        frontCardTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 32).isActive = true
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
    
    func populateEditCard(cardId: Int) {
        let viewModel = CardViewModel()
        
        viewModel.getCard(id: cardId) { card in
            frontCardTextField.text = card.frontCardString
            backCardTextField.text = card.backCardString
        }
    }
    
    func layoutForEditCard() {
        
        view.addSubviews(topLabel, frontCardTextField, backCardTextField, createButton)
        
        createButton.setTitle("Save Card", for: .normal)
        topLabel.text = "Edit card"
    
        
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        frontCardTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 32).isActive = true
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
    
    @objc func handleButtonPressed() {
        if isDeck {
            action.send((deckName: deckNameTextField.text, frontText: nil, backText: nil))
        } else if isEditMode {
            
            editAction.send((updatedFrontText: frontCardTextField.text, updatedBackText: backCardTextField.text))
            
           
        }
        else {
            action.send((deckName: nil, frontText: frontCardTextField.text, backText: backCardTextField.text))
        }
        resetTextField()
        dismiss(animated: true)
    }
    
    func resetTextField () {
        deckNameTextField.text = ""
        frontCardTextField.text = ""
        backCardTextField.text = ""
    }
}
