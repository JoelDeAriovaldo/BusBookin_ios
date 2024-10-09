//
//  BookingDetailsView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation
import UIKit

class BookingDetailsView: UIViewController {
    
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let booking: Booking
    
    init(booking: Booking) {
        self.booking = booking
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateBookingDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Detalhes da Reserva"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
    }
    
    private func populateBookingDetails() {
        addDetailLabel("ID da Reserva: \(booking.id)")
        addDetailLabel("Data da Reserva: \(formatDate(booking.bookingDate))")
        addDetailLabel("Status: \(booking.status.rawValue)")
        addDetailLabel("Preço Total: \(formatPrice(booking.totalPrice))")
        addDetailLabel("Assentos: \(booking.seats.joined(separator: ", "))")
        
        addSectionTitle("Passageiros:")
        for passenger in booking.passengers {
            addDetailLabel("\(passenger.name) - Assento \(passenger.seatNumber)")
        }
    }
    
    private func addSectionTitle(_ title: String) {
        let label = UILabel()
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 18)
        stackView.addArrangedSubview(label)
    }
    
    private func addDetailLabel(_ text: String) {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_MZ")
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
}
