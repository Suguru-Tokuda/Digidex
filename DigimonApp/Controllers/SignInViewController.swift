//
//  SignInViewController.swift
//  DigimonApp
//
//  Created by Suguru Tokuda on 11/2/23.
//

import UIKit

class SignInViewController: UIViewController {
    var mainLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Digidex"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var signInBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = UIColor.orange
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor.orange
        btn.setTitle("Sign In", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

extension SignInViewController {
    private func setUpUI() {
        signInBtn.addTarget(self, action: #selector(signInBtnTap), for: .touchUpInside)
        view.addSubview(mainLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInBtn)
        
        applyConstraints()
    }
    
    /**
     Validate email and password
     */
    private func isValidCredentials(email: String?, password: String?) -> Bool {
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

extension SignInViewController {
    func applyConstraints() {
        let mainLabelConstraints = [
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.bounds.height / 2 * 0.5)),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        let emailTextFieldConstraints = [
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            emailTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let signInBtnConstraints = [
            signInBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            signInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInBtn.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            signInBtn.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(mainLabelConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(signInBtnConstraints)
    }
}

extension SignInViewController {
    @objc func signInBtnTap() {
        if isValidCredentials(email: self.emailTextField.text, password: self.passwordTextField.text) {
            let vc = DigimonTableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Invalid Credentials", message: "Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}
