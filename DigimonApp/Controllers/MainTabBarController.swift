//
//  MainTabBarController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/3/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = DigimonTableViewController()
        let vc2 = DigimonCollectionViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        vc2.tabBarItem.image = UIImage(systemName: "square.grid.3x3")
        
        vc1.tabBarItem.title = "List"
        vc2.tabBarItem.title = "Grid"
        
        tabBar.tintColor = UIColor.theme.label
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
}
