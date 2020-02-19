//
//  RequestFactory.swift
//  swapi
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

final class RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func getData(_ urlString: String,
                         session: URLSession = URLSession(configuration: .default),
                         completion: ((Result<Data, ErrorType>) -> ())?) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            completion?(.failure(.wrongUrlRequest))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Method.GET.rawValue
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion?(.failure(.wrongUrlRequest))
                return
            }
            
            if let data = data {
                completion?(.success(data))
            }
            
        }
        task.resume()
        return task
    }
}
