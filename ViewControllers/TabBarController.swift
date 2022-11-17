//
//  TabBarController.swift
//  flashcard
//
//  Created by Victor Gustafsson on 2022-11-15.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sets = SetsViewController()
        
        let setItem = UITabBarItem(title: "Flashcard sets", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        sets.tabBarItem = setItem
        
        self.viewControllers = [sets]
        

    }
}
