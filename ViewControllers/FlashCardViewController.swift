//
//  FlashCardCollectionViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit


class FlashCardViewController: UIViewController, FlashCardCollectionViewDelegate {

    let pageControl = UIPageControl()
    
    let db = DBHelper()
    
    lazy var collectionView : FlashCardCollectionView = {
        var collectionView = FlashCardCollectionView()

        return collectionView
    }()
    
    var deckId: Int?
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(deckId: Int) {
       self.deckId = deckId
        
        super.init(nibName: nil, bundle: nil)
      
        
   }
    
    let layoutGuide = UILayoutGuide()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.add, style: .done, target: self, action: #selector(askForNewCard))
        
        view.backgroundColor = .white
        view.addLayoutGuide(layoutGuide)
        
        view.addSubViews(collectionView, pageControl)
        
        layoutGuide.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        layoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
        
        collectionView.flashCardDelegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        pageControl.pageIndicatorTintColor = .red
        pageControl.currentPageIndicatorTintColor = .green
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
    
    @objc func askForNewCard() {
        let alert = UIAlertController(title: "Add new flashcard", message: "Enter a name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter text.."
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter text.."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let textField2 = alert?.textFields![1]
            self.addNewCard(frontText: textField?.text ?? "", backText: textField2?.text ?? "")
        }))
        

    
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNewCard(frontText: String, backText: String){

        guard let deckId = deckId else { return }
        db.insertCard(front: frontText, back: backText, deck: deckId)
        collectionView.collectionView.reloadData()
        collectionView.reloadDbData()
        
    }
    
    func currentIndex(index: Int) {
        pageControl.currentPage = index
    }
    
    func totalItems(items: Int) {
        pageControl.numberOfPages = items
    }



}


