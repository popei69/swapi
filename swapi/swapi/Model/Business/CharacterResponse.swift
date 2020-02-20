//
//  CharacterResponse.swift
//  swapi
//
//  Created by Benoit Pasquier on 20/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

struct CharacterResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Character]
}

extension CharacterResponse {
    var sortedCharacters: [Character] {
        return results.sorted(by: { $0.name < $1.name })
    }
}
