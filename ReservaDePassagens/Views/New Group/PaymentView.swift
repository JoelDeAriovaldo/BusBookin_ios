//
//  PaymentView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation
import UIKit

class PaymentViewController: UIViewController {
    var viewModel: PaymentViewModel
    let booking: Booking
    
    init(viewModel: PaymentViewModel, booking: Booking) {
        self.viewModel = viewModel
        self.booking = booking
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Pagamento"
        
        let paymentMethodLabel = UILabel()
        paymentMethodLabel.text = "Método de Pagamento"
        paymentMethodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let paymentMethodSegmentedControl = UISegmentedControl(items: PaymentMethod.allCases.map { $0.rawValue })
        paymentMethodSegmentedControl.selectedSegmentIndex = viewModel.selectedPaymentMethod.rawValue
        paymentMethodSegmentedControl.addTarget(self, action: #selector(paymentMethodChanged), for: .valueChanged)
        paymentMethodSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = "Número de Telefone"
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let phoneNumberTextField = UITextField()
        phoneNumberTextField.placeholder = "Insira o número de telefone"
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.text = viewModel.phoneNumber
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let authorizeButton = UIButton(type: .system)
        authorizeButton.setTitle("Autorizar Pagamento", for: .normal)
        authorizeButton.addTarget(self, action: #selector(authorizePayment), for: .touchUpInside)
        authorizeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [
            paymentMethodLabel,
            paymentMethodSegmentedControl,
            phoneNumberLabel,
            phoneNumberTextField,
            authorizeButton
            ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
    }
    
    @objc private func paymentMethodChanged(_ sender: UISegmentedControl) {
        viewModel.selectedPaymentMethod = PaymentMethod(rawValue: sender.selectedSegmentIndex) ?? .creditCard
    }
    
    @objc private func authorizePayment() {
        viewModel.processPayment(for: booking)
        
        if viewModel.isProcessingPayment {
            let alert = UIAlertController(title: "Processando pagamento...", message: nil, preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        }
        
        if let errorMessage = viewModel.errorMessage {
            let alert = UIAlertController(title: "Erro", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        if viewModel.paymentStatus == .success {
            let alert = UIAlertController(title: "Pagamento Concluído", message: "Seu pagamento foi processado com sucesso.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
