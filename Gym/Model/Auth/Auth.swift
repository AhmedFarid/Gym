//
//  Auth.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation



struct Auth: Codable {
    let status: Bool?
    let error: String?
    let data: AuthData?
}


struct AuthData: Codable {
    let id: Int?
    let name, email, phone, address: String?
    let active: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, address, active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
