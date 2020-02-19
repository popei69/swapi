//
//  CharacterTests.swift
//  swapiTests
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import XCTest
@testable import swapi

class CharacterTests: XCTestCase {

    func test_valid_json_to_element() {
        // given a valid json string
        guard let data = try? FileManager.dataFromJson("Character") else {
            XCTFail("An error occured with mocked file")
            return
        }
        
        // when decoding value
        let formatter = JsonFormatter()
        let result: Result<Character, ErrorType> = formatter.decode(data)
        
        // expecting each field matching mocked data
        switch result {
        case .failure(_):
            XCTFail("No expecting any failure")
        case .success(let character):
            
            // expecting matching values
            XCTAssertEqual(character.name, "Luke Skywalker")
            XCTAssertEqual(character.height, "172")
            XCTAssertEqual(character.gender, "male")
            XCTAssertEqual(character.mass, "77")
            XCTAssertEqual(character.hairColor, "blond")
            XCTAssertEqual(character.skinColor, "fair")
            XCTAssertEqual(character.eyeColor, "blue")
            XCTAssertEqual(character.birthYear, "19BBY")
            XCTAssertEqual(character.filmEndpoints.count, 5)
        }
    }
    
    func test_invalid_json_to_element() {
        
        // given an invalid json format
        let data = "{ \"key\": \"value\"}".data(using: .utf8)!
        
        // when decoding value
        let formatter = JsonFormatter()
        let result: Result<Character, ErrorType> = formatter.decode(data)
        
        // expecting an error of format
        switch result {
        case .success(_):
            XCTFail("No expecting any matching character")
        case .failure(let error):
            XCTAssert(error == ErrorType.wrongFormat)
        }
    }
}

extension FileManager {
    
    static func dataFromJson(_ fileName: String) throws -> Data? {
        guard let url = Bundle(for: CharacterTests.self).url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        return try Data(contentsOf: url)
    }
}
