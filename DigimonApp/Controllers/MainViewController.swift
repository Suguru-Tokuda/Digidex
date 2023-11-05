//
//  ViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

class MainNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let signInViewController = SignInViewController()
        setViewControllers([signInViewController], animated: false)
    }
}
