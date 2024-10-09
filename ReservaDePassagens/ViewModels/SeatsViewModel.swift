//
//  SeatsViewModel.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation

import Foundation

class SeatsViewModel {
    // Array para armazenar os assentos
    private(set) var seats: [Seat]
    
    // Callback para notificar quando os assentos forem atualizados
    var onSeatsUpdated: (() -> Void)?
    
    init(seats: [Seat]) {
        self.seats = seats
    }
    
    // Função para selecionar/desselecionar um assento
    func toggleSeatSelection(at index: Int) {
        guard index >= 0 && index < seats.count else { return }
        seats[index].isSelected = !seats[index].isSelected
        onSeatsUpdated?()
    }

    
    // Retorna o número de assentos selecionados
    func selectedSeats() -> [Seat] {
        return seats.filter { $0.isSelected }
    }
    
    // Retorna a quantidade total de assentos selecionados
    func selectedSeatsCount() -> Int {
        return selectedSeats().count
    }
    
    // Reseta a seleção de assentos
    func resetSelections() {
        seats = seats.map { Seat(id: $0.id, number: $0.number, isAvailable: $0.isAvailable, isSelected: false) }
        onSeatsUpdated?()
    }
}

