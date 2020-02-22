//
//  FilmFetchable.swift
//  swapi
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

protocol RequestFetchable {
    func fetchContent<T>(_ urlString:String, completion: @escaping (Result<T, ErrorType>) -> ()) where T: Decodable
}

class RequestFetcher: RequestFetchable {
    
    public var task : URLSessionTask?
    
    public func cancelRequest() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
    
    func fetchContent<T>(_ urlString:String, completion: @escaping (Result<T, ErrorType>) -> ()) where T: Decodable {
        self.cancelRequest()
        
        task = RequestFactory.getData(urlString) { result in
            completion(JsonFormatter().decode(result))
        }
    }
}
