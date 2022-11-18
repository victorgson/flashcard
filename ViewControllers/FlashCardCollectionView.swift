//
//  FlashCardCollectionViewCollectionViewController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit

protocol FlashCardCollectionViewDelegate {
    func currentIndex(index: Int)
    func totalItems(items: Int)
}


class FlashCardCollectionView: UIView {
    
    var data: [CardModel] = [CardModel(frontCardString: "Front", backCardString: "Back"), CardModel(frontCardString: "Anekdot", backCardString: "Test")]
    
    var flashCardDelegate : FlashCardCollectionViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = false
        
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubViews(collectionView)
        
        collectionView.register(FlashCardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
extension FlashCardCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FlashCardCollectionViewCell
        cell.frontLabel.text = data[indexPath.item].frontCardString
        cell.backLabel.text = data[indexPath.item].backCardString
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
        
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(test(_ :)))
        addGestureRecognizer(longPress)
        
        
        
        UIView.transition(with: self, duration: 0.5, options: transitionOptions) {
            print(indexPath)
            let cell = collectionView.cellForItem(at: indexPath) as! FlashCardCollectionViewCell
            cell.flipCard()
            return
        }
    }
    
    @objc func test(_ sender: UILongPressGestureRecognizer) {
        if(sender.state == .began){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        flashCardDelegate?.currentIndex(index: indexPath.item)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        flashCardDelegate?.totalItems(items: data.count)
        return data.count
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.frame.width
        let parentHeight = self.frame.height
        return CGSize(width: cellWidth, height: parentHeight)
    }
    
    
}
