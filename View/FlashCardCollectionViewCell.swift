//
//  FlashCardCollectionViewCell.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit

class FlashCardCollectionViewCell: UICollectionViewCell {
    
    let cardView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        flipCard()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func layout() {
        addSubViews(cardView, label)
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    var isShowingFront = true
    func flipCard() {
        if isShowingFront {
            label.text = "Front"
            isShowingFront.toggle()
        } else {
            label.text = "Back"
            isShowingFront.toggle()
        }
    }
    override func prepareForReuse() {
        isShowingFront = true
        flipCard()
    }

}
