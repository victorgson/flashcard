//
//  UIViewExt.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-17.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...){
        views.forEach({self.addSubview($0)})
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
