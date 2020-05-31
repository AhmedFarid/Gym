//
//  aboutUs.swift
//  Gym
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//



import Foundation

struct AboutUs: Codable {
    let status: Bool?
    let error: String?
    let data: aboutUsData?
}

struct aboutUsData: Codable {
    let about, dataDescription: String?
    let image: String?
    let reviews: [aboutReview]?

    enum CodingKeys: String, CodingKey {
        case about
        case dataDescription = "description"
        case image, reviews
    }
}

struct aboutReview: Codable {
    let name, reviewDescription, rate: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case name
        case reviewDescription = "description"
        case rate, image
    }
}


