//
//  FilmTests.swift
//  swapiTests
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import XCTest
@testable import swapi

class FilmTests: XCTestCase {

    func test_valid_json_to_element() {
        // given a valid json string
        guard let data = try? FileManager.dataFromJson("Film") else {
            XCTFail("An error occured with mocked file")
            return
        }
        
        // when decoding value
        let formatter = JsonFormatter()
        let result: Result<Film, ErrorType> = formatter.decode(data)
        
        // expecting each field matching mocked data
        switch result {
        case .failure(_):
            XCTFail("No expecting any failure")
        case .success(let film):
            
            // expecting matching values
            XCTAssertEqual(film.title, "The Empire Strikes Back")
            XCTAssertEqual(film.episodeId, 5)
            XCTAssertFalse(film.openingCrawl.isEmpty)
        }
    }
    
    func test_invalid_json_to_element() {
        
        // given an invalid json format
        let data = "{ \"key\": \"value\"}".data(using: .utf8)!
        
        // when decoding value
        let formatter = JsonFormatter()
        let result: Result<Film, ErrorType> = formatter.decode(data)
        
        // expecting an error of format
        switch result {
        case .success(_):
            XCTFail("No expecting any matching character")
        case .failure(let error):
            XCTAssert(error == ErrorType.wrongFormat)
        }
    }

}
