//
//  PaymentViewModel.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//
import Foundation

enum PaymentMethod: String {
    case mpesa = "M-Pesa"
    case emola = "E-mola"
    case mkesh = "M-Kesh"
}

class PaymentViewModel {
    var selectedPaymentMethod: PaymentMethod = .mpesa {
        didSet {
            NotificationCenter.default.post(name: .paymentMethodChanged, object: nil)
        }
    }
    var phoneNumber: String = "" {
        didSet {
            NotificationCenter.default.post(name: .phoneNumberChanged, object: nil)
        }
    }
    var isProcessingPayment = false {
        didSet {
            NotificationCenter.default.post(name: .isProcessingPaymentChanged, object: nil)
        }
    }
    var paymentStatus: PaymentStatus = .idle {
        didSet {
            NotificationCenter.default.post(name: .paymentStatusChanged, object: nil)
        }
    }
    var errorMessage: String? {
        didSet {
            NotificationCenter.default.post(name: .errorMessageChanged, object: nil)
        }
    }
    
    private let paymentService: PaymentService
    
    init(paymentService: PaymentService = PaymentService()) {
        self.paymentService = paymentService
    }
    
    func processPayment(for booking: Booking) {
        guard validatePhoneNumber() else {
            errorMessage = "Número de telefone inválido. Por favor, insira um número válido."
            return
        }
        
        isProcessingPayment = true
        paymentStatus = .processing
        errorMessage = nil
        
        paymentService.processPayment(booking: booking, method: selectedPaymentMethod, phoneNumber: phoneNumber) { [weak self] success, error in
            self?.isProcessingPayment = false
            if success {
                self?.paymentStatus = .success
            } else {
                self?.paymentStatus = .failed
                self?.errorMessage = error?.localizedDescription ?? "Falha no pagamento. Por favor, tente novamente."
            }
        }
    }
    
    private func validatePhoneNumber() -> Bool {
        let phoneRegex = "^\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    enum PaymentStatus {
        case idle
        case processing
        case success
        case failed
    }
}

extension Notification.Name {
    static let paymentMethodChanged = Notification.Name("paymentMethodChanged")
    static let phoneNumberChanged = Notification.Name("phoneNumberChanged")
    static let isProcessingPaymentChanged = Notification.Name("isProcessingPaymentChanged")
    static let paymentStatusChanged = Notification.Name("paymentStatusChanged")
    static let errorMessageChanged = Notification.Name("errorMessageChanged")
}
