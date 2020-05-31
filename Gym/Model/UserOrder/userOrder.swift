//
//  userOrder.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct UserOrders: Codable {
    let status: Bool?
    let error: String?
    let data: [userOrdersData]?
}


struct userOrdersData: Codable {
    let id, code: Int?
    let status: String?
    let shippingPrice, total: Double?
    let currency: String?
}



struct UserOrdersDetiles: Codable {
    let status: Bool?
    let error: String?
    let data: UserOrdersDetilesData?
}

struct UserOrdersDetilesData: Codable {
    let id, code: Int?
    let status: String?
    let shippingPrice, total: Double?
    let currency: String?
    let products: [UserOrdersDetilesProductData]?
}

struct UserOrdersDetilesProductData: Codable {
    let id: Int?
    let title, price: String?
    let quantity: Int?
    let image: String?
}
