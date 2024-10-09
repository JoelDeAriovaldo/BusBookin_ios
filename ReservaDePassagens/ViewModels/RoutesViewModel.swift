//
//  RoutesViewModel.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation

class RoutesViewModel {
    var searchQuery: String = ""
    var routes: [Route] = []
    var isLoading: Bool = false
    
    func searchRoutes(from: String, to: String, date: Date, query: String) {
        guard !query.isEmpty else {
            routes = []
            return
        }
        isLoading = true
        // Simulate a network call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.routes = [
                Route(id: 1, name: "Route 1", from: from, to: to, date: date, details: "Details of Route 1"),
                Route(id: 2, name: "Route 2", from: from, to: to, date: date, details: "Details of Route 2")
            ]
            self.isLoading = false
        }
    }
}
