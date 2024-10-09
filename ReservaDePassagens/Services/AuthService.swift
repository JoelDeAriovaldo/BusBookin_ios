//
//  AuthService.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    private var users: [User] = [
        User(name: "Test User", email: "user@example.com", password: "password")
    ]
    
    func login(email: String, password: String) -> Bool {
        return users.contains { $0.email == email && $0.password == password }
    }
    
    func signUp(name: String, email: String, password: String) -> Bool {
        guard !users.contains(where: { $0.email == email }) else {
            return false
        }
        let newUser = User(name: name, email: email, password: password)
        users.append(newUser)
        return true
    }
}
