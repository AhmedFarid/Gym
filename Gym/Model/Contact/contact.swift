//
//  contact.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//
import Foundation


struct Contact: Codable {
    let status: Bool?
    let error: String?
    let data: contactData?
}

struct contactData: Codable {
    let address, phone1, phone2, email: String?
    let map: String?

    enum CodingKeys: String, CodingKey {
        case address
        case phone1 = "phone_1"
        case phone2 = "phone_2"
        case email, map
    }
}
