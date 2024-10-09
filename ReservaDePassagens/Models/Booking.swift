//
//  Booking.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//


import Foundation

struct Booking: Codable {
    let id: String
    let userId: String
    let routeId: String
    let seats: [String]
    let passengers: [Passenger]
    let totalPrice: Double
    let bookingDate: Date
    let status: BookingStatus
    
    enum BookingStatus: String, Codable {
        case pending
        case confirmed
        case cancelled
    }
}

struct Passenger: Codable {
    let name: String
    let documentNumber: String
    let seatNumber: String
}
