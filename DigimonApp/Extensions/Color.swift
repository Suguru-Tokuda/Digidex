//
//  Color.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

extension UIColor {
    static let theme = ColorTheme()
    
    struct ColorTheme {
        let background = UIColor(named: "Background")
        let labelColor = UIColor(named: "LabelColor")
    }
}
