//
//  BookingsViewModel.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation

class BookingsViewModel {
    private let bookingService: BookingService
    private(set) var bookings: [Booking] = []
    
    init(bookingService: BookingService = BookingService()) {
        self.bookingService = bookingService
    }
    
    func fetchBookings(completion: @escaping (Result<Void, Error>) -> Void) {
        bookingService.fetchBookings { [weak self] result in
            switch result {
            case .success(let bookings):
                self?.bookings = bookings
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelBooking(_ booking: Booking, completion: @escaping (Result<Void, Error>) -> Void) {
        bookingService.cancelBooking(booking) { [weak self] result in
            switch result {
            case .success:
                if let index = self?.bookings.firstIndex(where: { $0.id == booking.id }) {
                    self?.bookings[index].status = .cancelled
                }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// Mocked BookingService for compilation
class BookingService {
    func fetchBookings(completion: @escaping (Result<[Booking], Error>) -> Void) {
        // Implement API call to fetch bookings
    }
    
    func cancelBooking(_ booking: Booking, completion: @escaping (Result<Void, Error>) -> Void) {
        // Implement API call to cancel booking
    }
}
