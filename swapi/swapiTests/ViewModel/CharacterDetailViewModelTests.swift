//
//  CharacterDetailViewModelTests.swift
//  swapiTests
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import XCTest
@testable import swapi

class CharacterDetailViewModelTests: XCTestCase {
    
    fileprivate var fetcher: MockFilmFetcher!

    override func setUp() {
        super.setUp()
        fetcher = MockFilmFetcher()
    }

    override func tearDown() {
        fetcher = nil
        super.tearDown()
    }

    func test_fetch_film_with_data() {
        // given a fetcher with valid data
        let film = Film(title: "Hello movie", episodeId: 1, openingCrawl: "Hello there")
        fetcher.data = film
        
        // when fetching data
        let viewModel = CharacterDetailViewModel(character: Character(name: "Ben", gender: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", films: []))
        let expectation = XCTestExpectation(description: "Detail data handler")
        
        viewModel.fetchFilm("", fetcher: fetcher) { result in
            switch result {
            case .failure(_):
                XCTFail("Expecting error ")
            case .success(let newFilm):
                XCTAssertEqual(film.title, newFilm.title)
            }
            expectation.fulfill()
        }
        
        // expecting data triggered
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_fetch_film_with_error() {
        // given a fetcher with invalid data
        fetcher.data = nil
        
        // when fetching data
        let viewModel = CharacterDetailViewModel(character: Character(name: "Ben", gender: "", height: "", mass: "", hairColor: "", skinColor: "", eyeColor: "", birthYear: "", films: []))
        let expectation = XCTestExpectation(description: "Detail error handler")
        
        viewModel.fetchFilm("", fetcher: fetcher) { result in
            switch result {
            case .failure(_):
                break
            case .success(let film):
                XCTFail("Expecting error ")
            }
            expectation.fulfill()
        }
        
        // expecting data triggered
        wait(for: [expectation], timeout: 3.0)
    }
}


fileprivate class MockFilmFetcher: RequestFetchable {
    
    var data: Decodable?
    
    func fetchContent<T>(_ urlString: String, completion: @escaping (Result<T, ErrorType>) -> ()) where T : Decodable {
        if let data = data as? T {
            completion(.success(data))
        } else {
            completion(.failure(.unknown))
        }
    }
}
