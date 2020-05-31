//
//  reviews.swift
//  Gym
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct Reviews: Codable {
    let status: Bool?
    let error: String?
    let data: DataClass?
}


struct DataClass: Codable {
    let id: Int?
    let title, dataDescription, more, price: String?
    let discount, quantity, rate: Int?
    let isFavorite: Bool?
    let images: [String]?
    let reviews: [Review]?

    enum CodingKeys: String, CodingKey {
        case id, title
        case dataDescription = "description"
        case more, price, discount, quantity, rate, isFavorite, images, reviews
    }
}


struct Review: Codable {
    let name, reviewDescription, rate: String?

    enum CodingKeys: String, CodingKey {
        case name
        case reviewDescription = "description"
        case rate
    }
}
