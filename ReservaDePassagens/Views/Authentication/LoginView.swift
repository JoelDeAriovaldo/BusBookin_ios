//
//  LoginView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_bus"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress // Setting email keyboard type
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye"), for: .normal) // Replace with your eye image
        button.setImage(UIImage(named: "eye.slash"), for: .selected) // Replace with your eye.slash image
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Entrar", for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1.0) // Approx systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Não tem uma conta? Cadastre-se", for: .normal)
        button.setTitleColor(UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1.0), for: .normal) // Approx systemBlue
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var isPasswordVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupPasswordVisibilityToggle()
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    private func setupPasswordVisibilityToggle() {
        passwordTextField.rightView = togglePasswordButton
        passwordTextField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible = !isPasswordVisible
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        togglePasswordButton.isSelected = !togglePasswordButton.isSelected // Switches the eye icon
    }
    
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Por favor, insira um e-mail válido.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Por favor, insira sua senha.")
            return
        }
        
        // Simulated login process
        performLogin(email: email, password: password)
    }
    
    private func performLogin(email: String, password: String) {
        // This is a placeholder for your actual login logic
        // You should replace this with your actual authentication process
        
        // Simulating an asynchronous login process
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // For this example, we'll consider the login successful if the email contains "@" and the password is not empty
            if email.contains("@") && !password.isEmpty {
                self?.loginSuccess()
            } else {
                self?.showAlert(message: "Login falhou. Por favor, verifique suas credenciais.")
            }
        }
    }
    
    private func loginSuccess() {
        // Create and navigate to the SearchRoutesViewController
        let searchRoutesVC = SearchRoutesViewController()
        
        // If you're using a UINavigationController
        if let navigationController = self.navigationController {
            navigationController.pushViewController(searchRoutesVC, animated: true)
        } else {
            // If you're not using a UINavigationController, you can present it modally
            searchRoutesVC.modalPresentationStyle = .fullScreen
            self.present(searchRoutesVC, animated: true, completion: nil)
        }
    }
    
    @objc private func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // Dismiss the keyboard when tapping outside text fields
    }
}
