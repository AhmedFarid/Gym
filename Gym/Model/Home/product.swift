//
//  product.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct Product: Codable {
    let status: Bool?
    let error: String?
    let data: [productData]?
}


struct productData: Codable {
    let id: Int?
    let title: String?
    let datumDescription, more: String?
    let price: String?
    let discount, quantity, rate: Int?
    let isFavorite: Bool?
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case more, price, discount, quantity, rate, isFavorite, images
    }
}
