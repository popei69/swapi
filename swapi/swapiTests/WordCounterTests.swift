//
//  WordCounterTests.swift
//  swapiTests
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import XCTest
@testable import swapi

class WordCounterTests: XCTestCase {

    func test_simple_word_count() {
        // given a sentence of 3 words
        let input = "hello lightspeed team"
        
        // when counting word,
        // expecting 3 words
        XCTAssertEqual(input.wordCount, 3)
    }
    
    func test_complexe_word_count() {
        // given a sentence of 6 words
        // and including extra spacing
        let input = "hello\r\nlightspeed\r\nteam, how are you?"
        
        // when counting word,
        // expecting 6 words
        XCTAssertEqual(input.wordCount, 6)
    }
    
    func test_multiple_breakline_word_count() {
        // given a sentence of 3 words
        // and including multiple breakdown
        let input = "hello\r\n\r\nlightspeed\r\nteam"
        
        // when counting word,
        // expecting 3 words
        XCTAssertEqual(input.wordCount, 3)
    }
}
