//
//  SignInViewModel.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/9/23.
//

import Foundation

class SignInViewModel {
    func isValidCredentials(email: String?, password: String?) -> Bool {
        var isValid = false
        
        guard let email = email else { return isValid }
        guard let password = password else { return isValid }
        
        let isValidPassword = password.count >= 6
        let emailRegex = "[A-Za-z0-9.%+-]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isEmailValid = emailPredicate.evaluate(with: email)
        
        isValid = isValidPassword && isEmailValid
        
        return isValid
    }
}
