//
//  ColorCircleView.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-25.
//

import UIKit

class ColorCircleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
   
     
    }
    
    func test() {
        self.layer.cornerRadius = layer.bounds.width / 2
        self.clipsToBounds = true
        backgroundColor = UIColor.white.withAlphaComponent(0)
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 5.0
    }
    

    
//    override func draw(_ rect: CGRect) {
//        let circlePath = UIBezierPath(ovalIn: rect)
//        let color = UIColor.systemOrange
//               color.set()
//               circlePath.fill()
//    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
