//
//  NSObject.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/5/23.
//

import Foundation

extension NSObject {
    var className: String {
        get {
            return NSStringFromClass(type(of: self))
        }
    }
}
