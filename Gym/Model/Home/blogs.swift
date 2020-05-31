//
//  blogs.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct blogs: Codable {
    let status: Bool?
    let error: String?
    let data: [blogsData]?
}


struct blogsData: Codable {
    let id: Int?
    let title, datumDescription: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case image
    }
}
