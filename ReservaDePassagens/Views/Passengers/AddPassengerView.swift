//
//  AddPassengerView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation
import UIKit

class AddPassengerView: UIViewController {
    
    private var viewModel: PassengersViewModel
    
    // UI Elements
    private let nameTextField = UITextField()
    private let documentTextField = UITextField()
    private let ageTextField = UITextField()
    private let primarySwitch = UISwitch()
    private let saveButton = UIButton(type: .system)
    
    init(viewModel: PassengersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adicionar Passageiro"
        view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        // Configurar Name TextField
        nameTextField.placeholder = "Nome do Passageiro"
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        
        // Configurar Document TextField
        documentTextField.placeholder = "Número do Documento"
        documentTextField.borderStyle = .roundedRect
        view.addSubview(documentTextField)
        
        // Configurar Age TextField
        ageTextField.placeholder = "Idade"
        ageTextField.borderStyle = .roundedRect
        ageTextField.keyboardType = .numberPad
        view.addSubview(ageTextField)
        
        // Configurar Primary Switch
        let primaryLabel = UILabel()
        primaryLabel.text = "Passageiro Principal"
        primaryLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(primaryLabel)
        view.addSubview(primarySwitch)
        
        // Configurar Save Button
        saveButton.setTitle("Salvar Passageiro", for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(savePassenger), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        documentTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        primarySwitch.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            documentTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            documentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            documentTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            ageTextField.topAnchor.constraint(equalTo: documentTextField.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            primarySwitch.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            primarySwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            saveButton.topAnchor.constraint(equalTo: primarySwitch.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    // MARK: - Save Passenger
    
    @objc private func savePassenger() {
        guard let name = nameTextField.text, !name.isEmpty,
            let documentNumber = documentTextField.text, !documentNumber.isEmpty,
            let ageText = ageTextField.text, let age = Int(ageText) else {
                // Adicione um alerta para campos inválidos
                let alert = UIAlertController(title: "Erro", message: "Por favor, preencha todos os campos corretamente.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
        }
        
        let isPrimary = primarySwitch.isOn
        viewModel.addPassenger(name: name, documentNumber: documentNumber, age: age, isPrimary: isPrimary)
        
        // Navegar para a tela anterior ou mostrar confirmação
        navigationController?.popViewController(animated: true)
    }
}
