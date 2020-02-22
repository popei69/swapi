//
//  CharacterFetcher.swift
//  swapi
//
//  Created by Benoit PASQUIER on 19/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation


protocol CharacterFetchable {
    func getAllCharacters(_ completion: @escaping (Result<[Character], ErrorType>) -> ())
}

class CharacterFetcher: CharacterFetchable {
 
    private let host = "https://swapi.co"
    private var task : URLSessionTask?
    
    private func makeUrlString(_ page: Int?) -> String? {
        var urlComponents = URLComponents(string: host)
        urlComponents?.path = "/api/people"
        
        if let page = page {
            urlComponents?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        }
        return urlComponents?.string
    }
    
    func getAllCharacters(_ completion: @escaping (Result<[Character], ErrorType>) -> ()) {
        getCharacters(from: [], completion: completion)
    }
    
    func getCharacters(_ page: Int = 1, from characters: [Character], completion: @escaping (Result<[Character], ErrorType>) -> ()) {
        
        getCharacterResponse(page) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .failure(let error):
                
                // if previous page empty, pass the error
                if characters.isEmpty {
                    completion(.failure(error))
                } else {
                    
                    // otherwise consider as success (i.e: if 5 pages loaded, but 6th failed)
                    completion(.success(characters))
                }
            case .success(let response):
                
                let fullCharacters = characters + response.results
                
                // create recursivity for next page
                if response.next != nil {
                    let newPage = page + 1
                    strongSelf.getCharacters(newPage, from: fullCharacters, completion: completion)
                } else {
                    
                    // return latest full list known
                    completion(.success(fullCharacters))
                }
            }
        }
    }
    
    func getCharacterResponse(_ page: Int = 1, completion: @escaping (Result<CharacterResponse, ErrorType>) -> ()) {
        
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
