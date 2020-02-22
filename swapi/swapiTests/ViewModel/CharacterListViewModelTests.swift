//
//  CharacterListViewModelTests.swift
//  swapiTests
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import XCTest
@testable import swapi

class CharacterListViewModelTests: XCTestCase {
    
    var viewModel: CharacterListViewModel!
    fileprivate var fetcher: MockCharacterFetcher!

    override func setUp() {
        super.setUp()
        fetcher = MockCharacterFetcher()
        viewModel = CharacterListViewModel(fetchable: fetcher)
    }

    override func tearDown() {
        viewModel = nil
        fetcher = nil
        super.tearDown()
    }

    func test_sorted_character() {
        // given an array of character
        let character1 = Character(name: "Ben", gender: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", films: [])
        let character2 = Character(name: "Tom", gender: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", films: [])
        
        var characters = [character2, character1]
        
        // when passing to view model sort
        viewModel.sortedCharacters(&characters)
        
        // expecting them sorted by name ASC
        XCTAssertEqual(characters.first?.name, character1.name)
        XCTAssertEqual(characters.last?.name, character2.name)
    }
    
    func test_fetch_character_with_error() {
        // given a mocked error from fetcher
        fetcher.characters = nil
        let expectation = XCTestExpectation(description: "List error handler")
        
        // when trying to fetch character
        viewModel.output.errorHandler.subscribe(self) { _ in
            expectation.fulfill()
        }
        
        // expected error handler getting trigger
        viewModel.fetchCharacters()
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_fetch_character_with_valid_value() {
        // given a mocked characters from fetcher
        let characters = [Character(name: "Ben", gender: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", films: [])]
        fetcher.characters = characters
        let expectation = XCTestExpectation(description: "List data handler")
        
        // when trying to fetch character
        viewModel.output.errorHandler.subscribe(self) { _ in
            XCTFail("Not expecting any error")
        }
        
        viewModel.output.characters.subscribe(self) { data in 
            XCTAssertEqual(data.count, characters.count)
            expectation.fulfill()
        }
        
        // expected data handler getting trigger
        viewModel.fetchCharacters()
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_tap_index_with_value() {
        // given a known dataset to viewModel
        viewModel.output.characters.value = [Character(name: "Ben", gender: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", films: [])]
        let expectation = XCTestExpectation(description: "Tap index handler")
        
        // when tapping on first row
        viewModel.output.showDetail.subscribe(self) { character in
            XCTAssertEqual(character?.name, "Ben")
            expectation.fulfill()
        }
        
        // expecting navigating to matching character
        viewModel.input.tapIndex.value = IndexPath(row: 0, section: 0)
        wait(for: [expectation], timeout: 3.0)
    }
}

fileprivate class MockCharacterFetcher: CharacterFetchable {
    
    var characters: [Character]?
    
    func getAllCharacters(_ completion: @escaping (Result<[Character], ErrorType>) -> ()) {
        
        if let characters = characters {
            completion(.success(characters))
        } else {
            completion(.failure(.unknown))
        }
    }
    
}
