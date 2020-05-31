//
//  message.swift
//  Gym
//
//  Created by Ahmed farid on 5/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation


struct Message: Codable {
    let status: Bool?
    let error, data: String?
}
