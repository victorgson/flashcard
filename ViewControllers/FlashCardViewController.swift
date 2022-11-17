//
//  FlashCardCollectionViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit


class FlashCardViewController: UIViewController, FlashCardCollectionViewDelegate {

    let pageControl = UIPageControl()
    
    lazy var collectionView : FlashCardCollectionView = {
        var collectionView = FlashCardCollectionView()
        
        return collectionView
    }()
    
    let layoutGuide = UILayoutGuide()

    override func viewDidLoad() {
        super.viewDidLoad()

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

        pageControl.numberOfPages = 20
        
 
    }
    
    func currentIndex(index: Int) {
        pageControl.currentPage = index
    }

}


