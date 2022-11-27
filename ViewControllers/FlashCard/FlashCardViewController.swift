//
//  FlashCardCollectionViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit
import Combine


class FlashCardViewController: UIViewController {

    let pageControl = UIPageControl()
    
    let db = DBHelper()
    
    let viewModel = CardViewModel()
    
    let vc = PageSheetViewController(isDeck: false)
    
    let layoutGuide = UILayoutGuide()
    
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
    

    private var cancellables: [AnyCancellable] = []
    
    func bindViewModel () {
        viewModel.$data.sink { [weak self] result in
            self?.collectionView.data = result
            self?.collectionView.collectionView.reloadData()
        }.store(in: &cancellables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
       
        if let id = deckId {
            viewModel.getCards(inDeck: id)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(askForNewCard))
        
        guard let deckId = deckId else { return }
        vc.action.sink(receiveValue: { [weak self] result in
            self?.db.insertCard(front: result.frontText!, back: result.backText!, deck: deckId)
            self?.viewModel.getCards(inDeck: deckId)
            self?.collectionView.collectionView.reloadData()
        }).store(in: &cancellables)
        

        
        observeCardToDelete()
        observePageControlInputs()
        setupAndLayout()

    }
    
    func observeCardToDelete() {
        collectionView.cardIndexToDelete.sink { [weak self] index in
            self?.db.deleteCard(index: index)
            self?.collectionView.collectionView.reloadData()
            self?.viewModel.getCards(inDeck: self!.deckId!)
        }.store(in: &cancellables)
    }
    
    func observePageControlInputs() {
        collectionView.currentIndex.sink { [weak self] index in
            self?.pageControl.currentPage = index
        }.store(in: &cancellables)
        
        collectionView.totalItems.sink { [weak self] totalItems in
            self?.pageControl.numberOfPages = totalItems
        }.store(in: &cancellables)
    }
    
    @objc func askForNewCard() {
        vc.modalPresentationStyle = .pageSheet
        vc.sheetPresentationController?.detents = [.medium()]
        present(vc, animated: true)
    }
}

extension FlashCardViewController {
    
    func setupAndLayout() {
        view.backgroundColor = .systemBackground
        view.addLayoutGuide(layoutGuide)
        view.addSubviews(collectionView, pageControl)
        
        layoutGuide.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        layoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
      
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        pageControl.pageIndicatorTintColor = .tertiaryLabel
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}


