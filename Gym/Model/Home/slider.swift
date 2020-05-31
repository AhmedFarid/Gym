//
//  slider.swift
//  Gym
//
//  Created by Ahmed farid on 5/6/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct Slider: Codable {
    let status: Bool?
    let error: String?
    let data: [sliderData]?
}


struct sliderData: Codable {
    let title, datumDescription: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case title
        case datumDescription = "description"
        case image
    }
}
