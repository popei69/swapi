//
//  CharacterResponseTests.swift
//  swapiTests
//
//  Created by Benoit Pasquier on 20/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import XCTest
@testable import swapi

class CharacterResponseTests: XCTestCase {

    func test_valid_json_to_element() {
        // given a valid json string
        guard let data = try? FileManager.dataFromJson("CharacterResponse") else {
            XCTFail("An error occured with mocked file")
            return
        }
        
        // when decoding value
        let formatter = JsonFormatter()
        let result: Result<CharacterResponse, ErrorType> = formatter.decode(data)
        
        // expecting each field matching mocked data
        switch result {
        case .failure(_):
            XCTFail("No expecting any failure")
        case .success(let response):
            
            // expecting matching values
            XCTAssertEqual(response.count, 87)
            XCTAssertNil(response.previous)
            XCTAssertNotNil(response.next)
            XCTAssertEqual(response.results.count, 1)
        }
    }
    
    func test_invalid_json_to_element() {
        
        // given an invalid json format
        let data = "{ \"key\": \"value\"}".data(using: .utf8)!
        
        // when decoding value
        let formatter = JsonFormatter()
        let result: Result<CharacterResponse, ErrorType> = formatter.decode(data)
        
        // expecting an error of format
        switch result {
        case .success(_):
            XCTFail("No expecting any matching character")
        case .failure(let error):
            XCTAssert(error == ErrorType.wrongFormat)
        }
    }
}
