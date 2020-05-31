//
//  checkOut.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct shippingCategories: Codable {
    let status: Bool?
    let error: String?
    let data: [shippingCategoriesData]?
}


struct shippingCategoriesData: Codable {
    let id: Int?
    let name: String?
}



struct shippingServices: Codable {
    let status: Bool?
    let error: String?
    let data: [shippingServicesData]?
}

// MARK: - Datum
struct shippingServicesData: Codable {
    let id: Int?
    let name, cost: String?
}



struct OrderMessage: Codable {
    let status: Bool?
    let error: String?
    let data: OrderMessageData?
}

// MARK: - DataClass
struct OrderMessageData: Codable {
    let message: String?
    let orderID: Int?

    enum CodingKeys: String, CodingKey {
        case message
        case orderID = "orderId"
    }
}
