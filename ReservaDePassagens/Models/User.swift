//
//  User.swift
//  ReservaDePassagens
//
//  Created by Equip Mozambique on 10/5/24.
//  Copyright © 2024 Joel De Ariovaldo. All rights reserved.
//

import Foundation

struct User {
    var id: UUID
    var name: String
    var email: String
    var password: String
    
    init(id: UUID = UUID(), name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
