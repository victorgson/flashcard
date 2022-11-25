//
//  FlashCardCollectionViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit
import Combine


class FlashCardViewController: UIViewController, FlashCardCollectionViewDelegate {

    let pageControl = UIPageControl()
    
    let db = DBHelper()
    
    let viewModel = CardViewModel()
    
    let vc = PageSheetViewController(isDeck: false)
    
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
    
    func updateData() {
        collectionView.data = viewModel.data
        collectionView.collectionView.reloadData()
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func bindViewModel () {
        viewModel.$data.sink { [weak self] _ in
            self?.updateData()
        }.store(in: &cancellables)
    }
    
    let layoutGuide = UILayoutGuide()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
       
   
        if let id = deckId {
            viewModel.getCards(inDeck: id)
            collectionView.data = viewModel.data
            collectionView.collectionView.reloadData()
        }

 
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.add, style: .done, target: self, action: #selector(askForNewCard))
        
        view.backgroundColor = .white
        view.addLayoutGuide(layoutGuide)
        
        view.addSubviews(collectionView, pageControl)
        
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
        
        vc.modalPresentationStyle = .pageSheet
        vc.sheetPresentationController?.detents = [.medium()]
            
        vc.cardDetails = { [weak self] (frontText, backText) in
            self?.addNewCard(frontText: frontText, backText: backText)
            print(frontText, backText)
        }
       present(vc, animated: true)
        

    }
    
    func addNewCard(frontText: String, backText: String){
        
        guard let deckId = deckId else { return }
        db.insertCard(front: frontText, back: backText, deck: deckId)
        viewModel.getCards(inDeck: deckId)
        collectionView.data = viewModel.data
        collectionView.collectionView.reloadData()
        

        
    }
    
    func currentIndex(index: Int) {
        pageControl.currentPage = index
    }
    
    func totalItems(items: Int) {
        pageControl.numberOfPages = items
    }
    
    func didDelete() {
        viewModel.getCards(inDeck: deckId!)
        collectionView.data = viewModel.data
        collectionView.collectionView.reloadData()
    }

//    func onCreatePressed(deckName: String?, frontText: String?, backText: String?) {
//        guard let frontText = frontText, let backText = backText else  {
//            return
//        }
//        addNewCard(frontText: frontText, backText: backText)
//    }
    
    func onDismiss() {
        // NA
    }

}


