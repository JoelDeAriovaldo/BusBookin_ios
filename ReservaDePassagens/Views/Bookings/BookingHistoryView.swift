//
//  BookingHistoryView.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation
import UIKit

class BookingHistoryView: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: BookingsViewModel
    
    init(viewModel: BookingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadBookings()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Histórico de Reservas"
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BookingCell")
    }
    
    private func loadBookings() {
        viewModel.fetchBookings { [weak self] result in
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension BookingHistoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingCell", for: indexPath)
        let booking = viewModel.bookings[indexPath.row]
        cell.textLabel?.text = "Reserva #\(booking.id) - \(booking.bookingDate)"
        cell.detailTextLabel?.text = "Status: \(booking.status.rawValue)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let booking = viewModel.bookings[indexPath.row]
        let detailsView = BookingDetailsView(booking: booking)
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
