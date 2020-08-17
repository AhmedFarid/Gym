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
      let title, datumDescription: String?
      let more: String?
      let discount, rate: Int?
      let isFavorite: Bool?
      let images: [String]?
      let sizes: [ProductSize]?

         enum CodingKeys: String, CodingKey {
              case id, title
                    case datumDescription = "description"
                    case more, discount, rate, isFavorite, images, sizes
         }
     }
struct ProductSize: Codable {
    let id: Int?
    let price: String?
    let quantity: Quantity?
}


enum Quantity: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Quantity.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Quantity"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
