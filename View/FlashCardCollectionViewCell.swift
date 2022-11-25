//
//  FlashCardCollectionViewCell.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import UIKit

class FlashCardCollectionViewCell: UICollectionViewCell {
    
    let cardBackTag: Int = 0
    let cardFrontTag: Int = 1
    
    var cardViews : (frontView: UIView, backView: UIView)?
    
    let frontView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let backView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen
        return view
    }()
    
    var frontLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var backLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    
    func layout() {
        cardViews = (frontView: frontView, backView: backView)
        
        contentView.addSubviews(backView, frontView)
        
        frontView.addSubview(frontLabel)
        backView.addSubview(backLabel)
        
     
        frontView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        frontView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        frontView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        frontView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        frontLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor).isActive = true
        frontLabel.centerYAnchor.constraint(equalTo: frontView.centerYAnchor).isActive = true
        
        backLabel.centerXAnchor.constraint(equalTo: frontView.centerXAnchor).isActive = true
        backLabel.centerYAnchor.constraint(equalTo: frontView.centerYAnchor).isActive = true
        
        frontView.isHidden = false
        backView.isHidden = true

    }
    

    func flipCard() {
        backView.isHidden.toggle()
        frontView.isHidden.toggle()
    
    }
    override func prepareForReuse() {
//        frontView.isHidden = false
//        backView.isHidden = true
        frontLabel.text = ""
        backLabel.text = ""
        frontView.backgroundColor = .systemBlue
        backView.backgroundColor = .systemGreen
        
    }

}
