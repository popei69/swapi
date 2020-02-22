//
//  Character.swift
//  swapi
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

struct Character: Codable {
    let name: String
    let gender: String
    
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    
    let films: [String]
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case gender = "gender"
        case height = "height"
        case mass = "mass"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case films = "films"
    }
}
