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
        let vc3 = UIKitToSwiftUIViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        vc2.tabBarItem.image = UIImage(systemName: "square.grid.3x3")
        vc3.tabBarItem.image = UIImage(systemName: "swift")
        
        vc1.tabBarItem.title = "List"
        vc2.tabBarItem.title = "Grid"
        vc3.tabBarItem.title = "SwiftUI"
        
        tabBar.tintColor = UIColor.theme.labelColor
        
        setViewControllers([vc1, vc2, vc3], animated: true)
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
