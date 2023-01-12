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
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        return view
    }()
    
    let backView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        return view
    }()
    
    var frontLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var backLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var completedIcon : UIImageView = {
        let imageView = UIImageView()
        var completed = true
        
        if(completed) {
            let img = UIImage(systemName: "checkmark.circle.fill")!.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .systemGreen
            imageView.image = img
        }
     
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        contentView.addSubviews(backView, frontView, completedIcon)
        
        frontView.addSubviews(frontLabel)
        backView.addSubviews(backLabel)
 
     
        completedIcon.isHidden = true
        
        frontView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        frontView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        frontView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        frontView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        frontLabel.leadingAnchor.constraint(equalTo: frontView.leadingAnchor, constant: 16).isActive = true
        frontLabel.trailingAnchor.constraint(equalTo: frontView.trailingAnchor, constant: -16).isActive = true
        frontLabel.topAnchor.constraint(equalTo: frontView.topAnchor).isActive = true
        frontLabel.bottomAnchor.constraint(equalTo: frontView.bottomAnchor).isActive = true
        
        backLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16).isActive = true
        backLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16).isActive = true
        backLabel.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        backLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        
        completedIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        completedIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true

        
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
        completedIcon.isHidden = true

        
        
    }

}
