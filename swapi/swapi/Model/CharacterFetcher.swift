//
//  CharacterFetcher.swift
//  swapi
//
//  Created by Benoit PASQUIER on 19/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

struct CharacterResponse: Codable {
    let count: Int
    let next: String
    let previous: String
    let results: [Character] 
}

protocol CharacterFetchable {
    func getCharacters(_ page: Int?, completion: @escaping (Result<CharacterResponse, ErrorType>) -> ())
}

class CharacterFetcher: CharacterFetchable {
 
    private let host = "https://swapi.co/"
    private var task : URLSessionTask?
    
    private func makeUrlString(_ page: Int?) -> String? {
        var urlComponents = URLComponents(string: host)
        urlComponents?.path = "api/people"
        
        if let page = page {
            urlComponents?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        }
        return urlComponents?.string
    }
    
    func getCharacters(_ page: Int? = nil, completion: @escaping (Result<CharacterResponse, ErrorType>) -> ()) {
        
        // stop previous request before starting new one
        self.cancelRequest()
        
        guard let urlString = makeUrlString(page) else {
            completion(.failure(.wrongUrlRequest))
            return
        }
        
        task = RequestFactory.getData(urlString) { result in
            completion(JsonFormatter().decode(result))
        }
    }
    
    private func cancelRequest() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
} 
