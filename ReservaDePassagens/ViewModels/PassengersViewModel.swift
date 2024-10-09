//
//  PassengersViewModel.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation

class PassengersViewModel {
    private(set) var passengers: [Passenger] = []
    
    var onPassengersUpdated: (() -> Void)?
    
    func addPassenger(name: String, documentNumber: String, age: Int, isPrimary: Bool) {
        let passenger = Passenger(name: name, documentNumber: documentNumber, age: age, isPrimary: isPrimary)
        passengers.append(passenger)
        onPassengersUpdated?()
    }
    
    func removePassenger(at index: Int) {
        guard index < passengers.count else { return }
        passengers.remove(at: index)
        onPassengersUpdated?()
    }
}
