//
//  banner.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct banner: Codable {
    let status: Bool?
    let error: String?
    let data: [bannerData]?
}


struct bannerData: Codable {
    let id: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case image
    }
}
