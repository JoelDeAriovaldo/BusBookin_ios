//
//  Seat.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation

struct Seat {
    var id: Int
    var number: String
    var isAvailable: Bool
    var isSelected: Bool
    
    init(id: Int, number: String, isAvailable: Bool = true, isSelected: Bool = false) {
        self.id = id
        self.number = number
        self.isAvailable = isAvailable
        self.isSelected = isSelected
    }
}
