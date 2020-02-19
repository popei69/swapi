//
//  WordCounter.swift
//  swapi
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

extension String {
    
    var wordCount: Int {
        return self
            .replacingOccurrences(of: "\r\n", with: " ") // replace extra chars
            .split(separator: " ") // split by space
            .filter { !$0.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty } // remove any blank one
            .count
    }
}
