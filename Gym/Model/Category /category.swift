//
//  category.swift
//  Dabberha
//
//  Created by Ahmed farid on 5/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation



struct Category: Codable {
    let status: Bool?
    let error: String?
    let data: [categoryData]?
}


struct categoryData: Codable {
    let id: Int?
    let title: String?
    let image: String?
}
