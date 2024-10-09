//
//  SelectSeatsView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import UIKit

class SelectSeatsView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var viewModel: SeatsViewModel
    private var collectionView: UICollectionView!
    
    // Botão para navegar para outra tela
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continuar", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: SeatsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Seleção de Assentos"
        view.backgroundColor = .white
        
        setupCollectionView()
        setupContinueButton()
        
        viewModel.onSeatsUpdated = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: - UI Setup
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SeatCell.self, forCellWithReuseIdentifier: "SeatCell")
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20)
            ])
    }
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func continueButtonTapped() {
        let viewModel = PassengersViewModel() // Crie uma instância de PassengersViewModel
        let nextVC = AddPassengerView(viewModel: viewModel) // Passe o viewModel para o inicializador de AddPassengerView
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - Collection View Data Source & Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCell", for: indexPath) as? SeatCell else {
            return UICollectionViewCell()
        }
        let seat = viewModel.seats[indexPath.item]
        cell.configure(with: seat)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.toggleSeatSelection(at: indexPath.item)
    }
}

// MARK: - Seat Cell

class SeatCell: UICollectionViewCell {
    
    private let seatLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(seatLabel)
        seatLabel.translatesAutoresizingMaskIntoConstraints = false
        seatLabel.textAlignment = .center
        seatLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        NSLayoutConstraint.activate([
            seatLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            seatLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with seat: Seat) {
        seatLabel.text = seat.number
        contentView.backgroundColor = seat.isAvailable ? (seat.isSelected ? .blue : .green) : .gray
        seatLabel.textColor = .white
    }
}
