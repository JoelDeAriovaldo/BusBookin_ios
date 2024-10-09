//
//  RoutesDetailsView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import UIKit

class RouteDetailsViewController: UIViewController {
    var route: Route
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    
    private let nameLabel = UILabel()
    private let fromLabel = UILabel()
    private let toLabel = UILabel()
    private let dateLabel = UILabel()
    private let detailsLabel = UILabel()
    
    private let selectSeatsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Selecionar Assentos", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initialization
    init(route: Route) {
        self.route = route
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Adiciona a ação para o botão
        selectSeatsButton.addTarget(self, action: #selector(didTapSelectSeatsButton), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        setupScrollView()
        setupStackView()
        setupLabels()
        setupButton()
        setupConstraints()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabels() {
        configureLabel(nameLabel, text: route.name, fontSize: 24, weight: .bold)
        configureLabel(fromLabel, text: "De: \(route.from)", fontSize: 16)
        configureLabel(toLabel, text: "Para: \(route.to)", fontSize: 16)
        configureLabel(dateLabel, text: "Data: \(route.date)", fontSize: 16)
        configureLabel(detailsLabel, text: route.details, fontSize: 14)
        detailsLabel.numberOfLines = 0
        
        [nameLabel, fromLabel, toLabel, dateLabel, detailsLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func setupButton() {
        stackView.addArrangedSubview(selectSeatsButton)
        selectSeatsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureLabel(_ label: UILabel, text: String, fontSize: CGFloat, weight: UIFont.Weight = .regular) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = .darkGray
        label.textAlignment = .left
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
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
    }
    
    // MARK: - Actions
    @objc private func didTapSelectSeatsButton() {
//        let seats: [Seat] = [
//            Seat(id: 1, number: "1A", isAvailable: true, isSelected: false),
//            Seat(id: 2, number: "1B", isAvailable: true, isSelected: false),
//            Seat(id: 3, number: "1C", isAvailable: true, isSelected: false),
//            Seat(id: 4, number: "1D", isAvailable: true, isSelected: false),
//            Seat(id: 5, number: "2A", isAvailable: true, isSelected: false),
//            Seat(id: 6, number: "2B", isAvailable: true, isSelected: false),
//            Seat(id: 7, number: "2C", isAvailable: true, isSelected: false),
//            Seat(id: 8, number: "2D", isAvailable: true, isSelected: false),
//            Seat(id: 9, number: "3A", isAvailable: true, isSelected: false),
//            Seat(id: 10, number: "3B", isAvailable: true, isSelected: false),
//            Seat(id: 11, number: "3C", isAvailable: true, isSelected: false),
//            Seat(id: 12, number: "3D", isAvailable: true, isSelected: false),
//            Seat(id: 13, number: "4A", isAvailable: false, isSelected: false),
//            Seat(id: 14, number: "4B", isAvailable: false, isSelected: false),
//            Seat(id: 15, number: "4C", isAvailable: false, isSelected: false),
//            Seat(id: 16, number: "4D", isAvailable: false, isSelected: false)
//        ]
        
        let viewModel = PassengersViewModel() // Crie uma instância de PassengersViewModel
        let nextVC = AddPassengerView(viewModel: viewModel) // Passe o viewModel para o inicializador de AddPassengerView
        navigationController?.pushViewController(nextVC, animated: true)
    }
    }

