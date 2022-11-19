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
    
    var data: [CardModel]!
    
    let db = DBHelper()
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
        
        
        reloadDbData()
        
        self.addSubViews(collectionView)
        
        collectionView.register(FlashCardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func reloadDbData(){
        data = db.selectCards()
    }
    
    
}
extension FlashCardCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FlashCardCollectionViewCell
        cell.frontLabel.text = data[indexPath.item].frontCardString
        cell.backLabel.text = data[indexPath.item].backCardString
        let longPress = CustomTapGesture(target: self, action: #selector(longPressOnCard(_:)))
        let index = data[indexPath.item].id
       
        addGestureRecognizer(longPress)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromRight

//     print(indexPath.item)
        
        print(data[indexPath.item].id)
        
        UIView.transition(with: self, duration: 0.5, options: transitionOptions) {
   
            let cell = collectionView.cellForItem(at: indexPath) as! FlashCardCollectionViewCell
            cell.flipCard()
            return
        }
    }
    

    @objc func longPressOnCard(_ sender: CustomTapGesture) {
        if(sender.state == .began){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                self.deleteCard(sender.index!)
//                print(sender.index!)
                
            }
        }

    }
    
    func deleteCard(_ indexToDelete: Int) {
        let index = data[indexToDelete].id
        print(index)
        let indexSet = IndexSet(arrayLiteral: indexToDelete)
  
        db.deleteCard(index: index)
        reloadDbData()
        collectionView.reloadData()

        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        flashCardDelegate?.currentIndex(index: indexPath.item)
    }
        
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
           configureContextMenu(index: indexPath.item)
       }
    
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration{
            let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
                
//                let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
//                    print("edit button clicked")
//                }
                let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
                    self.deleteCard(index)
                }
                
                return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.singleSelection, children: [delete])
                
            }
            return context
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
