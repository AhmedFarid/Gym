//
//  aboutUS.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation

// MARK: - Cart
struct Cart: Codable {
    let status: Bool?
    let error: String?
    let data: cartData?
}

// MARK: - DataClass
struct cartData: Codable {
    let totalPrice: Double?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let id: Int?
    let title, itemDescription, more, price: String?
    let discount, quantity, rate, userQuantity: Int?
    let total: Double?
    let isFavorite: Bool?
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case itemDescription = "description"
        case more, price, discount, quantity, rate, userQuantity, total, isFavorite, images
    }
}
