//
//  Film.swift
//  swapi
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

struct Film: Codable {
    let title: String
    let episodeId: Int
    let openingCrawl: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
    }
}
