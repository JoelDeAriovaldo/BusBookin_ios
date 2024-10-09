//
//  SigbUpView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_bus"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameTextField: UITextField = createTextField(placeholder: "Nome", keyboardType: .default)
    private lazy var emailTextField: UITextField = createTextField(placeholder: "E-mail", keyboardType: .emailAddress)
    private lazy var passwordTextField: UITextField = createTextField(placeholder: "Senha", isSecure: true)
    
    private lazy var togglePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.setImage(UIImage(named: "eye.slash"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cadastrar", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Properties
    
    private var isPasswordVisible = false
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardHandling()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(errorLabel)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        setupPasswordVisibilityToggle()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
    }
    
    private func setupPasswordVisibilityToggle() {
        passwordTextField.rightView = togglePasswordButton
        passwordTextField.rightViewMode = .always
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Helper Methods
    
    private func createTextField(placeholder: String, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.setLeftPadding(20)
        textField.autocapitalizationType = .none
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.errorLabel.alpha = 1
        }
    }
    
    private func hideError() {
//        UIView.animate(withDuration: 0.3) {
//            self.errorLabel.alpha = 0
//        } completion: { _ in
//            self.errorLabel.isHidden = true
//        }
    }
    
    // MARK: - Actions
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible = !isPasswordVisible
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        togglePasswordButton.isSelected = isPasswordVisible
    }
    
    @objc private func signUpButtonTapped() {
        hideError()
        
        guard let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                showError("Todos os campos são obrigatórios.")
                return
        }
        
        // Simulated sign-up logic
        if AuthService.shared.signUp(name: name, email: email, password: password) {
            // Success
            // Navigate to next screen if needed
        } else {
            showError("Falha no cadastro. Por favor, tente novamente.")
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UITextField Extension

extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

// Mocked AuthService for compilation
//struct AuthService {
//    static let shared = AuthService()
//
//    func signUp(name: String, email: String, password: String) -> Bool {
//        // Implement your actual sign-up logic here
//        return true
//    }
//}
