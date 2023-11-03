//
//  ViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let signInViewController = SignInViewController()
        setViewControllers([signInViewController], animated: false)
    }
}

